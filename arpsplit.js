// arpsplit — order-of-arrival note -> MIDI-channel SCULPTOR.
//
// You sculpt the distribution by dragging a per-channel bar graph of live note
// counts. Each distinct pitch keeps a STICKY channel assignment: the same pitch
// always returns to its channel until you explicitly move it. Pitch & velocity
// pass through unchanged — only the channel is chosen.
//
// PLACEMENT of a brand-new pitch: it piles onto the WORKING channel = the
// RIGHTMOST populated channel (the very first pitch goes to ch1). Dragging a bar
// down peels notes to the next channel, so the working channel walks 1->2->3->4.
//
// DRAG a bar DOWN = peel its NEWEST notes off (earliest residents stay) -> pushed
//   to the next channel on the right, building a left-to-right staircase.
// DRAG a bar UP = reclaim notes from the channels to its right back into it.
//
// Channels 1..nChannels are the pool (nChannels = the "channels" selector).
// The rightmost channel always catches — there is no separate overflow lane.
//
// Held notes go off on the channel they sounded on (held[]), so moving notes
// mid-phrase never hangs a note. This object only handles note messages; other
// voice messages pass through elsewhere in the patch.

autowatch = 1;
inlets = 1;
outlets = 8;
// 0: note pair [pitch, velocity]  -> midiformat note inlet (left)
// 1: channel 1..16                -> midiformat channel inlet (right)
// 2: last incoming pitch          -> display
// 3: last assigned channel        -> display
// 4: per-channel counts (8 ints)  -> multislider (bar graph)
// 5: [channel, pitch, velocity]   -> route -> per-channel send buses
// 6: channels (1..8)              -> channels number (reflect restored state)
// 7: state list                   -> pattr arpsplit_state (persistence)

setoutletassist(0, "note [pitch velocity] -> midiformat note inlet");
setoutletassist(1, "channel 1-16 -> midiformat channel (right) inlet");
setoutletassist(2, "last incoming pitch (display)");
setoutletassist(3, "last assigned channel (display)");
setoutletassist(4, "per-channel counts -> multislider");
setoutletassist(5, "[channel pitch velocity] -> route -> send buses");
setoutletassist(6, "channels -> channels number (on restore)");
setoutletassist(7, "state -> pattr arpsplit_state (persistence)");

var MAXCH = 8;    // channels 1..8

var rankOf = new Array(128);   // pitch -> arrival rank (order of first appearance), -1 = unseen
var chOf   = new Array(128);   // pitch -> assigned channel (0 = unseen)
var held   = new Array(128);   // pitch -> channel currently sounding (0 = not held)
var nextRank = 0;              // rank to hand the next never-seen pitch
var nChannels = 4;             // active pool size, 1..MAXCH
var muting = false;            // guard: ignore the multislider echo from our own refresh

function initAll() {
	for (var i = 0; i < 128; i++) { rankOf[i] = -1; chOf[i] = 0; held[i] = 0; }
	nextRank = 0;
}
initAll();

// ---- model queries -------------------------------------------------------

function countOn(c) {
	var n = 0;
	for (var p = 0; p < 128; p++) if (chOf[p] === c) n++;
	return n;
}

// pitches currently assigned to channel c, sorted by rank (oldest first).
function pitchesOn(c) {
	var arr = [];
	for (var p = 0; p < 128; p++) if (chOf[p] === c) arr.push(p);
	arr.sort(function (a, b) { return rankOf[a] - rankOf[b]; });
	return arr;
}

// ---- note flow -----------------------------------------------------------

function rightmostPopulated() {
	for (var c = nChannels; c >= 1; c--) if (countOn(c) > 0) return c;
	return 0; // nothing placed yet
}

// new pitches pile onto the working channel = the rightmost populated channel
// (first pitch -> ch1); peeling moves the working channel right.
function placeNew(pitch) {
	var c = rightmostPopulated();
	chOf[pitch] = (c === 0) ? 1 : c;
}

function list() {
	if (arguments.length < 2) return;
	var pitch = arguments[0] | 0;
	var velocity = arguments[1] | 0;
	if (pitch < 0 || pitch > 127) return;

	var ch, isNew = false;
	if (velocity > 0) {                    // note-on
		if (rankOf[pitch] < 0) {           // first appearance: rank + place
			rankOf[pitch] = nextRank++;
			placeNew(pitch);
			isNew = true;
		}
		ch = chOf[pitch] || 1;
		held[pitch] = ch;                  // remember for the matching note-off
	} else {                               // note-off: leave on the channel it sounded on
		ch = held[pitch];
		if (!ch) ch = chOf[pitch] || 1;
		held[pitch] = 0;
	}

	outlet(5, [ch, pitch, velocity]);  // demux to per-channel send bus
	outlet(1, ch);                     // set channel (cold) first...
	outlet(0, [pitch, velocity]);      // ...then the note triggers output
	outlet(2, pitch);
	outlet(3, ch);

	if (isNew) { refreshBars(); dump(); } // a new pitch changed the counts
}

// ---- sculpting (drag handling) -------------------------------------------

// move the `k` newest pitches off channel C to the next channel on the right
// (the last channel keeps them — nowhere further right to go).
function peel(C, k) {
	var res = pitchesOn(C);
	var movers = res.slice(res.length - k); // newest k (highest rank)
	for (var i = 0; i < movers.length; i++) {
		var p = movers[i];
		chOf[p] = (C < nChannels) ? C + 1 : C;
	}
}

// pull the `k` oldest pitches from channels right of C back into C.
function reclaim(C, k) {
	for (var i = 0; i < k; i++) {
		var src = -1;
		for (var c = C + 1; c <= nChannels; c++) if (countOn(c) > 0) { src = c; break; }
		if (src < 0) break;
		var res = pitchesOn(src);
		chOf[res[0]] = C; // oldest on that channel
	}
}

// the multislider sends its whole value list on a drag (via a `bars` message).
function bars() {
	if (muting) return; // our own refresh echoing back — ignore
	// Snapshot counts BEFORE changing anything: peeling ch1 raises ch2's count,
	// and if we recomputed mid-loop we'd see ch2 above its (untouched) slider and
	// peel it onward — cascading the notes across every channel to the right.
	var have = [];
	for (var c = 1; c <= nChannels; c++) have[c] = countOn(c);
	for (var c = 1; c <= nChannels; c++) {
		var want = (c - 1 < arguments.length) ? (arguments[c - 1] | 0) : 0;
		if (want < 0) want = 0;
		if (want < have[c]) peel(c, have[c] - want);
		else if (want > have[c]) reclaim(c, want - have[c]);
	}
	refreshBars(); // normalize the display to the actual result
	dump();
}

function refreshBars() {
	var out = [];
	for (var c = 1; c <= MAXCH; c++) out.push(c <= nChannels ? countOn(c) : 0);
	muting = true;
	outlet(4, out);
	muting = false;
}

// ---- config --------------------------------------------------------------

function channels(n) {
	n = n | 0;
	nChannels = n < 1 ? 1 : (n > MAXCH ? MAXCH : n);
	for (var p = 0; p < 128; p++) if (chOf[p] > nChannels) chOf[p] = nChannels; // pull strays into pool
	refreshBars();
	dump();
}

// relearn — forget all assignments for a genuinely new pattern. Held notes are
// preserved so any keys down right now still get a clean note-off.
function relearn() {
	for (var i = 0; i < 128; i++) { rankOf[i] = -1; chOf[i] = 0; }
	nextRank = 0;
	refreshBars();
	dump();
}
function bang() { relearn(); }

// debug: inject `n` fake notes (default 8) so the sliders have something to drag
// while editing with no MIDI coming in. They pile onto the working channel just
// like real note-ons; clear them with Re-learn.
function seed(n) {
	n = (n | 0) || 8;
	for (var i = 0; i < n; i++) {
		var p = -1;
		for (var q = 0; q < 128; q++) if (rankOf[q] < 0) { p = q; break; }
		if (p < 0) break; // every pitch already used
		rankOf[p] = nextRank++;
		placeNew(p);
	}
	refreshBars();
	dump();
}

// ---- persistence ---------------------------------------------------------
// State is mirrored to a top-level `pattr arpsplit_state` (Parameter Mode =
// Blob) in the device panel. dump() pushes the current state out outlet 7 to
// the pattr after every change; on load the pattr (banged by live.thisdevice)
// pushes the stored state back in as a `setstate ...` message. The `busy` guard
// stops the pattr's store-echo from looping back into setstate.
//   state = [ _, nChannels, nextRank, pitch,rank,channel, ... ]  ([0] is a
//   vestigial ex-mode slot, kept so the pattr restore default [0,4,0] still
//   parses; one triple per learned pitch).
var busy = false;

function snapshot() {
	var s = [0, nChannels, nextRank]; // s[0] vestigial (was mode)
	for (var p = 0; p < 128; p++) if (rankOf[p] >= 0) s.push(p, rankOf[p], chOf[p]);
	return s;
}

function dump() {
	if (busy) return;       // re-entrant (incl. our own pattr store-echo) -> skip
	busy = true;
	outlet(7, snapshot());
	busy = false;
}

function setstate() {
	if (busy) return;       // store-echo of our own dump -> ignore
	busy = true;
	var a = arguments;
	if (a.length >= 3) {
		for (var i = 0; i < 128; i++) { rankOf[i] = -1; chOf[i] = 0; }
		// a[0] is the vestigial ex-mode slot — ignored
		nChannels = a[1] | 0; if (nChannels < 1) nChannels = 1; else if (nChannels > MAXCH) nChannels = MAXCH;
		nextRank = a[2] | 0; if (nextRank < 0) nextRank = 0;
		for (var j = 3; j + 2 < a.length; j += 3) {
			var pp = a[j] | 0, rr = a[j + 1] | 0, cc = a[j + 2] | 0;
			if (pp >= 0 && pp < 128) { rankOf[pp] = rr; chOf[pp] = cc; }
		}
		outlet(6, nChannels);  // reflect to the channels number
		refreshBars();         // reflect counts to the multislider
	}
	busy = false;
}

// arpsplit — order-of-appearance pitch -> MIDI-channel allocator.
//
// Each distinct pitch is given a stable RANK = the order it first appeared
// (1st distinct pitch = rank 0, 2nd = rank 1, ...). The output channel is a
// pure function of (rank, group sizes): channels 1..15 form the pool, each
// holding `cap[c]` ranks; channel 16 is the overflow lane for ranks past the
// pool. Pitch and velocity pass through unchanged — only the channel is chosen.
//
// Because channel = f(rank, caps) and ranks never change once learned, the
// mapping is fully DETERMINISTIC and TUNABLE: changing the group sizes re-derives
// every pitch's channel consistently (no reset, no scramble), so you can A/B
// different distributions over a repeating phrase and compare apples to apples.
// A pitch always returns to the same channel for a given distribution, and
// held notes go off on the channel they came on with (no hung notes when caps
// change mid-note).
//
// This object only handles note messages. (Other voice messages pass through
// elsewhere in the patch.)

autowatch = 1;
inlets = 1;
outlets = 6;
// 0: note pair [pitch, velocity]  -> midiformat note inlet (left)
// 1: channel 1..16                -> midiformat channel inlet (right)
// 2: last incoming pitch          -> display
// 3: last assigned channel        -> display
// 4: caps list (15 ints)          -> multislider (echo after `distribute`)
// 5: [channel, pitch, velocity]   -> route -> per-group send buses

setoutletassist(0, "note [pitch velocity] -> midiformat note inlet");
setoutletassist(1, "channel 1-16 -> midiformat channel (right) inlet");
setoutletassist(2, "last incoming pitch (display)");
setoutletassist(3, "last assigned channel (display)");
setoutletassist(4, "caps list -> multislider (after distribute)");
setoutletassist(5, "[channel pitch velocity] -> route -> send buses");

var POOL = 15;       // channels 1..15 are allocatable
var OVERFLOW = 16;   // ranks past the pool ride here

var rank = new Array(128);     // pitch -> rank (order of first appearance), -1 = unseen
var held = new Array(128);     // pitch -> channel currently sounding (0 = not held)
var nextRank = 0;              // rank to assign to the next never-seen pitch
var cap = new Array(POOL + 1); // cap[1..15] = group size (ranks per channel)
var groupSize = 1;             // default fill value for `distribute`
var nChannels = POOL;          // default channel count for `distribute`

// Forget every learned rank — for when the underlying PATTERN changes (not when
// tuning the distribution). The next distinct pitches re-learn ranks from 0.
// Held notes are preserved so any keys down at this moment still get a matching
// note-off on the channel they sounded on (no hung notes from re-learning).
function relearn() {
	for (var i = 0; i < 128; i++) rank[i] = -1;
	nextRank = 0;
}
function bang() { relearn(); }

function clearHeld() {
	for (var i = 0; i < 128; i++) held[i] = 0;
}

function initCaps() {
	for (var c = 1; c <= POOL; c++) cap[c] = 1; // default: 1 rank per channel
}

initCaps();
clearHeld();
relearn();

// Channel for a given rank under the current group sizes: walk the pool,
// each channel swallowing cap[c] ranks; past the pool -> overflow.
function channelForRank(r) {
	var rem = r;
	for (var c = 1; c <= POOL; c++) {
		if (cap[c] <= 0) continue;
		if (rem < cap[c]) return c;
		rem -= cap[c];
	}
	return OVERFLOW;
}

// Note pair arrives from [midiparse] as a 2-int list: pitch velocity.
function list() {
	if (arguments.length < 2) return;
	var pitch = arguments[0] | 0;
	var velocity = arguments[1] | 0;
	if (pitch < 0 || pitch > 127) return;

	var ch;
	if (velocity > 0) {                  // note-on: learn rank on first appearance
		if (rank[pitch] < 0) rank[pitch] = nextRank++;
		ch = channelForRank(rank[pitch]);
		held[pitch] = ch;                // remember for the matching note-off
	} else {                             // note-off: leave on the channel it sounded on
		ch = held[pitch];
		if (!ch) ch = (rank[pitch] >= 0) ? channelForRank(rank[pitch]) : OVERFLOW;
		held[pitch] = 0;
	}

	outlet(5, [ch, pitch, velocity]); // demux to per-group send bus
	outlet(1, ch);                 // set channel (cold) first...
	outlet(0, [pitch, velocity]);  // ...then the note triggers output
	outlet(2, pitch);
	outlet(3, ch);
}

// caps <c1 c2 ... c15> — per-channel group sizes (from the multislider).
// Tuning the distribution does NOT clear ranks: channels just re-derive.
function caps() {
	for (var c = 1; c <= POOL; c++) {
		var v = (c - 1 < arguments.length) ? (arguments[c - 1] | 0) : 0;
		cap[c] = v < 0 ? 0 : v;
	}
}

// groupsize <g> / channels <n> — parameters for `distribute`.
function groupsize(g) { groupSize = (g | 0) < 0 ? 0 : (g | 0); }
function channels(n) {
	n = n | 0;
	nChannels = n < 1 ? 1 : (n > POOL ? POOL : n);
}

// distribute — fill the first nChannels channels with groupSize each, rest 0,
// then echo the resulting caps to the multislider so the UI stays in sync.
// The re-entrancy guard stops a feedback loop (e.g. a multislider miswired to
// this inlet, whose echo would re-trigger distribute) from overflowing the stack.
var inDistribute = false;
function distribute() {
	if (inDistribute) return;
	inDistribute = true;
	var out = [];
	for (var c = 1; c <= POOL; c++) {
		cap[c] = (c <= nChannels) ? groupSize : 0;
		out.push(cap[c]);
	}
	outlet(4, out);
	inDistribute = false;
}

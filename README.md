# arpsplit

A Max for Live MIDI effect that splits incoming notes across MIDI channels by
**order of arrival** — not by pitch — and lets you **sculpt** where each note
lands by dragging a per-channel bar graph.

![arpsplit device](arpsplit.png)

Why? So you can fan a melody, arpeggio, or chord out to several instruments
without zone-splitting by pitch — and shape the split by hand, deterministically.

## How it works

- Every new note **piles onto the working channel** — the rightmost channel that
  already holds notes (the very first note goes to **Ch 1**). Pitch and velocity
  pass through untouched; only the channel is chosen.
- Each distinct pitch is **sticky**: it always returns to the channel it's on
  until you move it. Held notes go off on the channel they sounded on, so
  reshaping mid-phrase never hangs a note.
- **Drag a bar down** to *peel* its newest notes onto the next channel to the
  right — building a left-to-right spread (Ch 1 → 2 → 3 …).
- **Drag a bar up** to *reclaim* notes back from the channels to its right.
- The whole sculpt is **saved with the Live Set** and restored on load.

## Panel

- **bar graph** — live per-channel note counts. Drag a bar to sculpt: **down**
  peels its newest notes one channel right, **up** reclaims notes from the right.
- **notes** — the count sitting on each channel.
- **ch 1–8** — the eight channels.
- **channels** — pool size: how many channels are in play (default 4).
- **re-learn** — forget every learned assignment; the next notes start over from
  Ch 1. Use it when you switch to a genuinely different pattern.
- **readout** — the last note's name and the channel it landed on.

## Routing in Ableton Live

arpsplit assigns each note a MIDI channel **and** broadcasts it to a global bus,
so pick the path that matches your setup. (Live flattens MIDI to one channel per
track on output and offers no per-channel track routing, so you can't split to
separate tracks by channel directly — use one of these.)

### A. One multitimbral instrument (same track)

If a single multitimbral instrument (Kontakt, Omnisphere, an External Instrument
to a hardware/IAC port, …) sits **after arpsplit on the same track**, it receives
every channel directly — Live only collapses channels *between* tracks. Set the
instrument to respond per-channel; channel = the bar the note landed on. Nothing
else to wire.

### B. Separate tracks — the `send`/`receive` buses

arpsplit also broadcasts each channel to a global send bus `arpsplit_ch1..16`.
The companion **arpsplit-recv** device receives one bus and outputs it locally,
sidestepping Live's channel limit entirely:

1. Put **arpsplit** on a MIDI track (no instrument needed; it's the master).
2. On each instrument track, add **arpsplit-recv** *before* the instrument and
   set its **Group** to the channel you want.
3. That track now plays only its channel — no MIDI-From routing, no IAC.

The bus names are **global**, so run **one arpsplit master per Live set**. Only
notes travel the buses; CC / pitch-bend / etc. stay on the master track (path A
still carries them per-channel).

## Install

Requires Ableton Live with Max for Live.

1. Download **`arpsplit.amxd`** (and **`arpsplit-recv.amxd`** if you want to fan
   out to separate tracks — path B). Grab them from the
   [latest release](../../releases) or download the raw files from this repo.
2. Drop **`arpsplit.amxd`** onto a MIDI track in Live.
3. Route it to your instrument(s) using one of the paths above.

The `.amxd` files are frozen (self-contained) — no other files needed to run
them. A ready-made example is in **`Sample Live Project/`** — open
`Arpsplit Sample Project.als` to see the devices wired up.

## Development

Logic lives in the v8 script + the abstraction; the `.amxd` is a thin shell with
the front-panel UI.

- `arpsplit.js` — the engine: stable pitch→rank map, sticky per-pitch channel
  assignments, drag-to-peel / drag-to-reclaim, and state save/restore. A `v8`
  object.
- `arpsplit.maxpat` — MIDI plumbing: `midiparse → v8 → midiformat`, plus
  `v8 → route → send arpsplit_ch1..16` to broadcast each channel. Inlets:
  `0` MIDI, `1` bars (multislider), `2` channels, `3` re-learn, `4` state (pattr),
  `5` seed (debug — injects fake notes so you can sculpt with no MIDI in).
- `arpsplit-recv.maxpat` — receiver: 16 `receive arpsplit_chN` → `switch`
  (Group selects the open bus) → `midiformat` → MIDI out.
- `validate_maxpat.mjs` — structural check: `node validate_maxpat.mjs <file>.maxpat`

To rebuild a device, edit the loose source files (keep them beside the `.amxd`),
then in Live's Max editor **Freeze (snowflake) → Save** to re-embed them.

### Notes / limitations

- Only **note** messages are split. CC, pitch-bend, aftertouch, etc. pass straight
  through; their channel follows the last note's.
- The pool is **8 channels**; the rightmost channel always catches — there is no
  separate overflow lane.
- `arpsplit.js` uses the `v8` object (Max 8.5+) but sticks to ES5-safe constructs.

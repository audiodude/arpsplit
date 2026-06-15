#!/usr/bin/env node
// Structural validator for Max .maxpat JSON.
// Catches the errors that otherwise only surface as silent failures in Max:
//   - invalid JSON
//   - duplicate / missing box ids
//   - patchlines referencing a non-existent box
//   - outlet/inlet indices out of range for the referenced box
// It does NOT verify object *semantics* (whether `sel` or `table` behave as wired) —
// that still needs a load+test in Max. This just guarantees the graph is well-formed.

import { readFileSync } from "node:fs";

const path = process.argv[2];
if (!path) {
	console.error("usage: node validate_maxpat.mjs <file.maxpat>");
	process.exit(2);
}

let doc;
try {
	doc = JSON.parse(readFileSync(path, "utf8"));
} catch (e) {
	console.error(`✗ invalid JSON: ${e.message}`);
	process.exit(1);
}

const p = doc.patcher;
if (!p || !Array.isArray(p.boxes)) {
	console.error("✗ no patcher.boxes array");
	process.exit(1);
}

const errors = [];
const warnings = [];
const boxes = new Map(); // id -> {numinlets, numoutlets, text}

for (const wrap of p.boxes) {
	const b = wrap.box;
	if (!b || !b.id) {
		errors.push("box with no id");
		continue;
	}
	if (boxes.has(b.id)) errors.push(`duplicate box id: ${b.id}`);
	boxes.set(b.id, {
		numinlets: b.numinlets ?? 0,
		numoutlets: b.numoutlets ?? 0,
		text: b.text ?? b.maxclass ?? "?",
	});
}

const lines = Array.isArray(p.lines) ? p.lines : [];
const indeg = new Map([...boxes.keys()].map((id) => [id, 0]));
const outdeg = new Map([...boxes.keys()].map((id) => [id, 0]));

for (const wrap of lines) {
	const l = wrap.patchline;
	if (!l || !Array.isArray(l.source) || !Array.isArray(l.destination)) {
		errors.push("malformed patchline");
		continue;
	}
	const [sid, sout] = l.source;
	const [did, din] = l.destination;
	const s = boxes.get(sid);
	const d = boxes.get(did);
	const where = `${sid}[${sout}] -> ${did}[${din}]`;

	if (!s) errors.push(`patchline source missing box: ${where}`);
	else if (sout < 0 || sout >= s.numoutlets)
		errors.push(`outlet ${sout} out of range (0..${s.numoutlets - 1}) on ${sid} "${s.text}" — ${where}`);

	if (!d) errors.push(`patchline dest missing box: ${where}`);
	else if (din < 0 || din >= d.numinlets)
		errors.push(`inlet ${din} out of range (0..${d.numinlets - 1}) on ${did} "${d.text}" — ${where}`);

	if (s) outdeg.set(sid, outdeg.get(sid) + 1);
	if (d) indeg.set(did, indeg.get(did) + 1);
}

// Soft hints: dangling objects (excluding comments / inlets / outlets which legitimately have one side).
for (const [id, info] of boxes) {
	const isComment = info.text && info.numoutlets === 0 && info.numinlets <= 1;
	if (info.numoutlets > 0 && outdeg.get(id) === 0 && info.numinlets > 0 && indeg.get(id) === 0 && !isComment)
		warnings.push(`object "${info.text}" (${id}) is fully disconnected`);
}

for (const w of warnings) console.warn(`⚠ ${w}`);
if (errors.length) {
	for (const e of errors) console.error(`✗ ${e}`);
	console.error(`\n${errors.length} error(s).`);
	process.exit(1);
}
console.log(`✓ ${path}: ${boxes.size} boxes, ${lines.length} patchlines — structurally valid${warnings.length ? `, ${warnings.length} warning(s)` : ""}.`);

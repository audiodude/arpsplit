{
	"patcher": {
		"fileversion": 1,
		"appversion": { "major": 8, "minor": 5, "revision": 5, "architecture": "x64", "modernui": 1 },
		"classnamespace": "box",
		"rect": [ 80.0, 80.0, 520.0, 520.0 ],
		"boxes": [
			{ "box": { "id": "obj-1", "maxclass": "inlet", "comment": "MIDI note number (int)", "numinlets": 0, "numoutlets": 1, "outlettype": [ "int" ], "patching_rect": [ 20.0, 20.0, 30.0, 30.0 ] } },
			{ "box": { "id": "obj-2", "maxclass": "newobj", "text": "t i i", "numinlets": 1, "numoutlets": 2, "outlettype": [ "int", "int" ], "patching_rect": [ 20.0, 70.0, 60.0, 22.0 ] } },
			{ "box": { "id": "obj-5", "maxclass": "newobj", "text": "% 12", "numinlets": 2, "numoutlets": 1, "outlettype": [ "int" ], "patching_rect": [ 20.0, 120.0, 50.0, 22.0 ] } },
			{ "box": { "id": "obj-3", "maxclass": "newobj", "text": "/ 12", "numinlets": 2, "numoutlets": 1, "outlettype": [ "int" ], "patching_rect": [ 200.0, 120.0, 50.0, 22.0 ] } },
			{ "box": { "id": "obj-4", "maxclass": "newobj", "text": "- 2", "numinlets": 2, "numoutlets": 1, "outlettype": [ "int" ], "patching_rect": [ 200.0, 170.0, 50.0, 22.0 ] } },
			{ "box": { "id": "obj-6", "maxclass": "newobj", "text": "t b i", "numinlets": 1, "numoutlets": 2, "outlettype": [ "bang", "int" ], "patching_rect": [ 20.0, 170.0, 50.0, 22.0 ] } },
			{ "box": { "id": "obj-7", "maxclass": "newobj", "text": "+ 1", "numinlets": 2, "numoutlets": 1, "outlettype": [ "int" ], "patching_rect": [ 90.0, 220.0, 40.0, 22.0 ] } },
			{ "box": { "id": "obj-9", "maxclass": "message", "text": "C C# D D# E F F# G G# A A# B", "numinlets": 2, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 20.0, 270.0, 220.0, 22.0 ] } },
			{ "box": { "id": "obj-8", "maxclass": "newobj", "text": "zl nth", "numinlets": 2, "numoutlets": 2, "outlettype": [ "", "" ], "patching_rect": [ 20.0, 320.0, 60.0, 22.0 ] } },
			{ "box": { "id": "obj-10", "maxclass": "newobj", "text": "sprintf %s%d", "numinlets": 2, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 20.0, 380.0, 110.0, 22.0 ] } },
			{ "box": { "id": "obj-11", "maxclass": "outlet", "comment": "note name (symbol, e.g. G4)", "numinlets": 1, "numoutlets": 0, "patching_rect": [ 20.0, 430.0, 30.0, 30.0 ] } },
			{ "box": { "id": "obj-doc", "maxclass": "comment", "text": "MIDI note number -> name symbol (Ableton convention: C3=60, so octave = pitch/12 - 2).", "numinlets": 1, "numoutlets": 0, "patching_rect": [ 270.0, 70.0, 230.0, 60.0 ] } }
		],
		"lines": [
			{ "patchline": { "source": [ "obj-1", 0 ], "destination": [ "obj-2", 0 ] } },
			{ "patchline": { "source": [ "obj-2", 1 ], "destination": [ "obj-3", 0 ] } },
			{ "patchline": { "source": [ "obj-2", 0 ], "destination": [ "obj-5", 0 ] } },
			{ "patchline": { "source": [ "obj-3", 0 ], "destination": [ "obj-4", 0 ] } },
			{ "patchline": { "source": [ "obj-4", 0 ], "destination": [ "obj-10", 1 ] } },
			{ "patchline": { "source": [ "obj-5", 0 ], "destination": [ "obj-6", 0 ] } },
			{ "patchline": { "source": [ "obj-6", 1 ], "destination": [ "obj-7", 0 ] } },
			{ "patchline": { "source": [ "obj-6", 0 ], "destination": [ "obj-9", 0 ] } },
			{ "patchline": { "source": [ "obj-7", 0 ], "destination": [ "obj-8", 1 ] } },
			{ "patchline": { "source": [ "obj-9", 0 ], "destination": [ "obj-8", 0 ] } },
			{ "patchline": { "source": [ "obj-8", 0 ], "destination": [ "obj-10", 0 ] } },
			{ "patchline": { "source": [ "obj-10", 0 ], "destination": [ "obj-11", 0 ] } }
		]
	}
}

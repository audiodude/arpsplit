{
	"patcher": {
		"fileversion": 1,
		"appversion": { "major": 8, "minor": 5, "revision": 5, "architecture": "x64", "modernui": 1 },
		"classnamespace": "box",
		"rect": [ 80.0, 80.0, 700.0, 520.0 ],
		"boxes": [
			{ "box": { "id": "obj-grp", "maxclass": "inlet", "comment": "group (int 1-16) — which arpsplit bus this track plays", "numinlets": 0, "numoutlets": 1, "outlettype": [ "int" ], "patching_rect": [ 20.0, 20.0, 30.0, 30.0 ] } },
			{ "box": { "id": "obj-out", "maxclass": "outlet", "comment": "MIDI out (to midiout)", "numinlets": 1, "numoutlets": 0, "patching_rect": [ 20.0, 460.0, 30.0, 30.0 ] } },

			{ "box": { "id": "obj-clip", "maxclass": "newobj", "text": "clip 1 16", "numinlets": 1, "numoutlets": 1, "outlettype": [ "int" ], "patching_rect": [ 20.0, 70.0, 60.0, 22.0 ] } },
			{ "box": { "id": "obj-int", "maxclass": "newobj", "text": "i", "numinlets": 2, "numoutlets": 1, "outlettype": [ "int" ], "patching_rect": [ 20.0, 100.0, 40.0, 22.0 ] } },
			{ "box": { "id": "obj-tr", "maxclass": "newobj", "text": "t i b", "numinlets": 1, "numoutlets": 2, "outlettype": [ "int", "bang" ], "patching_rect": [ 20.0, 326.0, 60.0, 22.0 ] } },

			{ "box": { "id": "obj-switch", "maxclass": "newobj", "text": "switch 16", "numinlets": 17, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 20.0, 360.0, 560.0, 22.0 ] } },
			{ "box": { "id": "obj-format", "maxclass": "newobj", "text": "midiformat", "numinlets": 8, "numoutlets": 1, "outlettype": [ "int" ], "patching_rect": [ 20.0, 410.0, 220.0, 22.0 ] } },
			{ "box": { "id": "obj-flush", "maxclass": "newobj", "text": "midiflush", "numinlets": 1, "numoutlets": 1, "outlettype": [ "int" ], "patching_rect": [ 20.0, 435.0, 100.0, 22.0 ] } },

			{ "box": { "id": "obj-r1",  "maxclass": "newobj", "text": "receive arpsplit_ch1",  "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 20.0,  120.0, 130.0, 22.0 ] } },
			{ "box": { "id": "obj-r2",  "maxclass": "newobj", "text": "receive arpsplit_ch2",  "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 20.0,  150.0, 130.0, 22.0 ] } },
			{ "box": { "id": "obj-r3",  "maxclass": "newobj", "text": "receive arpsplit_ch3",  "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 20.0,  180.0, 130.0, 22.0 ] } },
			{ "box": { "id": "obj-r4",  "maxclass": "newobj", "text": "receive arpsplit_ch4",  "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 20.0,  210.0, 130.0, 22.0 ] } },
			{ "box": { "id": "obj-r5",  "maxclass": "newobj", "text": "receive arpsplit_ch5",  "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 160.0, 120.0, 130.0, 22.0 ] } },
			{ "box": { "id": "obj-r6",  "maxclass": "newobj", "text": "receive arpsplit_ch6",  "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 160.0, 150.0, 130.0, 22.0 ] } },
			{ "box": { "id": "obj-r7",  "maxclass": "newobj", "text": "receive arpsplit_ch7",  "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 160.0, 180.0, 130.0, 22.0 ] } },
			{ "box": { "id": "obj-r8",  "maxclass": "newobj", "text": "receive arpsplit_ch8",  "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 160.0, 210.0, 130.0, 22.0 ] } },
			{ "box": { "id": "obj-r9",  "maxclass": "newobj", "text": "receive arpsplit_ch9",  "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 300.0, 120.0, 140.0, 22.0 ] } },
			{ "box": { "id": "obj-r10", "maxclass": "newobj", "text": "receive arpsplit_ch10", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 300.0, 150.0, 140.0, 22.0 ] } },
			{ "box": { "id": "obj-r11", "maxclass": "newobj", "text": "receive arpsplit_ch11", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 300.0, 180.0, 140.0, 22.0 ] } },
			{ "box": { "id": "obj-r12", "maxclass": "newobj", "text": "receive arpsplit_ch12", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 300.0, 210.0, 140.0, 22.0 ] } },
			{ "box": { "id": "obj-r13", "maxclass": "newobj", "text": "receive arpsplit_ch13", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 450.0, 120.0, 140.0, 22.0 ] } },
			{ "box": { "id": "obj-r14", "maxclass": "newobj", "text": "receive arpsplit_ch14", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 450.0, 150.0, 140.0, 22.0 ] } },
			{ "box": { "id": "obj-r15", "maxclass": "newobj", "text": "receive arpsplit_ch15", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 450.0, 180.0, 140.0, 22.0 ] } },
			{ "box": { "id": "obj-r16", "maxclass": "newobj", "text": "receive arpsplit_ch16", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 450.0, 210.0, 140.0, 22.0 ] } },

			{ "box": { "id": "obj-doc", "maxclass": "comment", "text": "Plays one arpsplit group. Set group (1-16) to choose the bus; switch passes only that bus to midiout. Notes only (CC/etc. stay on the master track).", "numinlets": 1, "numoutlets": 0, "patching_rect": [ 20.0, 260.0, 560.0, 45.0 ] } }
		],
		"lines": [
			{ "patchline": { "source": [ "obj-grp", 0 ], "destination": [ "obj-clip", 0 ] } },
			{ "patchline": { "source": [ "obj-clip", 0 ], "destination": [ "obj-int", 0 ] } },
			{ "patchline": { "source": [ "obj-int", 0 ], "destination": [ "obj-tr", 0 ] } },
			{ "patchline": { "source": [ "obj-tr", 0 ], "destination": [ "obj-switch", 0 ] } },
			{ "patchline": { "source": [ "obj-tr", 1 ], "destination": [ "obj-flush", 0 ] } },

			{ "patchline": { "source": [ "obj-r1", 0 ],  "destination": [ "obj-switch", 1 ] } },
			{ "patchline": { "source": [ "obj-r2", 0 ],  "destination": [ "obj-switch", 2 ] } },
			{ "patchline": { "source": [ "obj-r3", 0 ],  "destination": [ "obj-switch", 3 ] } },
			{ "patchline": { "source": [ "obj-r4", 0 ],  "destination": [ "obj-switch", 4 ] } },
			{ "patchline": { "source": [ "obj-r5", 0 ],  "destination": [ "obj-switch", 5 ] } },
			{ "patchline": { "source": [ "obj-r6", 0 ],  "destination": [ "obj-switch", 6 ] } },
			{ "patchline": { "source": [ "obj-r7", 0 ],  "destination": [ "obj-switch", 7 ] } },
			{ "patchline": { "source": [ "obj-r8", 0 ],  "destination": [ "obj-switch", 8 ] } },
			{ "patchline": { "source": [ "obj-r9", 0 ],  "destination": [ "obj-switch", 9 ] } },
			{ "patchline": { "source": [ "obj-r10", 0 ], "destination": [ "obj-switch", 10 ] } },
			{ "patchline": { "source": [ "obj-r11", 0 ], "destination": [ "obj-switch", 11 ] } },
			{ "patchline": { "source": [ "obj-r12", 0 ], "destination": [ "obj-switch", 12 ] } },
			{ "patchline": { "source": [ "obj-r13", 0 ], "destination": [ "obj-switch", 13 ] } },
			{ "patchline": { "source": [ "obj-r14", 0 ], "destination": [ "obj-switch", 14 ] } },
			{ "patchline": { "source": [ "obj-r15", 0 ], "destination": [ "obj-switch", 15 ] } },
			{ "patchline": { "source": [ "obj-r16", 0 ], "destination": [ "obj-switch", 16 ] } },

			{ "patchline": { "source": [ "obj-switch", 0 ], "destination": [ "obj-format", 0 ] } },
			{ "patchline": { "source": [ "obj-format", 0 ], "destination": [ "obj-flush", 0 ] } },
			{ "patchline": { "source": [ "obj-flush", 0 ], "destination": [ "obj-out", 0 ] } }
		]
	}
}

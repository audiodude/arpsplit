{
	"patcher": {
		"fileversion": 1,
		"appversion": { "major": 8, "minor": 5, "revision": 5, "architecture": "x64", "modernui": 1 },
		"classnamespace": "box",
		"rect": [ 80.0, 80.0, 760.0, 400.0 ],
		"default_fontsize": 10.0,
		"boxes": [
			{ "box": { "id": "obj-help", "maxclass": "comment", "text": "Open this, Select All, Copy, then Paste into your device. The 15 number boxes land at y=146 under a multislider placed at x=14 y=38 w=368. Connect your caps-list source (multislider outlet) into the unpack inlet.", "numinlets": 1, "numoutlets": 0, "patching_rect": [ 14.0, 200.0, 600.0, 45.0 ] } },

			{ "box": { "id": "obj-unpack", "maxclass": "newobj", "text": "unpack 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0", "numinlets": 1, "numoutlets": 15, "outlettype": [ "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int" ], "patching_rect": [ 14.0, 110.0, 360.0, 22.0 ] } },

			{ "box": { "id": "obj-n0",  "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 14.000, 146.0, 24.533, 22.0 ] } },
			{ "box": { "id": "obj-n1",  "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 38.533, 146.0, 24.533, 22.0 ] } },
			{ "box": { "id": "obj-n2",  "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 63.067, 146.0, 24.533, 22.0 ] } },
			{ "box": { "id": "obj-n3",  "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 87.600, 146.0, 24.533, 22.0 ] } },
			{ "box": { "id": "obj-n4",  "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 112.133, 146.0, 24.533, 22.0 ] } },
			{ "box": { "id": "obj-n5",  "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 136.667, 146.0, 24.533, 22.0 ] } },
			{ "box": { "id": "obj-n6",  "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 161.200, 146.0, 24.533, 22.0 ] } },
			{ "box": { "id": "obj-n7",  "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 185.733, 146.0, 24.533, 22.0 ] } },
			{ "box": { "id": "obj-n8",  "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 210.267, 146.0, 24.533, 22.0 ] } },
			{ "box": { "id": "obj-n9",  "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 234.800, 146.0, 24.533, 22.0 ] } },
			{ "box": { "id": "obj-n10", "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 259.333, 146.0, 24.533, 22.0 ] } },
			{ "box": { "id": "obj-n11", "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 283.867, 146.0, 24.533, 22.0 ] } },
			{ "box": { "id": "obj-n12", "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 308.400, 146.0, 24.533, 22.0 ] } },
			{ "box": { "id": "obj-n13", "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 332.933, 146.0, 24.533, 22.0 ] } },
			{ "box": { "id": "obj-n14", "maxclass": "number", "triangle": 0, "ignoreclick": 1, "numinlets": 1, "numoutlets": 2, "outlettype": [ "", "bang" ], "patching_rect": [ 357.467, 146.0, 24.533, 22.0 ] } }
		],
		"lines": [
			{ "patchline": { "source": [ "obj-unpack", 0 ],  "destination": [ "obj-n0", 0 ] } },
			{ "patchline": { "source": [ "obj-unpack", 1 ],  "destination": [ "obj-n1", 0 ] } },
			{ "patchline": { "source": [ "obj-unpack", 2 ],  "destination": [ "obj-n2", 0 ] } },
			{ "patchline": { "source": [ "obj-unpack", 3 ],  "destination": [ "obj-n3", 0 ] } },
			{ "patchline": { "source": [ "obj-unpack", 4 ],  "destination": [ "obj-n4", 0 ] } },
			{ "patchline": { "source": [ "obj-unpack", 5 ],  "destination": [ "obj-n5", 0 ] } },
			{ "patchline": { "source": [ "obj-unpack", 6 ],  "destination": [ "obj-n6", 0 ] } },
			{ "patchline": { "source": [ "obj-unpack", 7 ],  "destination": [ "obj-n7", 0 ] } },
			{ "patchline": { "source": [ "obj-unpack", 8 ],  "destination": [ "obj-n8", 0 ] } },
			{ "patchline": { "source": [ "obj-unpack", 9 ],  "destination": [ "obj-n9", 0 ] } },
			{ "patchline": { "source": [ "obj-unpack", 10 ], "destination": [ "obj-n10", 0 ] } },
			{ "patchline": { "source": [ "obj-unpack", 11 ], "destination": [ "obj-n11", 0 ] } },
			{ "patchline": { "source": [ "obj-unpack", 12 ], "destination": [ "obj-n12", 0 ] } },
			{ "patchline": { "source": [ "obj-unpack", 13 ], "destination": [ "obj-n13", 0 ] } },
			{ "patchline": { "source": [ "obj-unpack", 14 ], "destination": [ "obj-n14", 0 ] } }
		]
	}
}

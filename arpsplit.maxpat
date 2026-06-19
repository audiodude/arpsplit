{
	"patcher": {
		"fileversion": 1,
		"appversion": {
			"major": 8,
			"minor": 5,
			"revision": 5,
			"architecture": "x64",
			"modernui": 1
		},
		"classnamespace": "box",
		"rect": [
			80.0,
			80.0,
			900.0,
			760.0
		],
		"boxes": [
			{
				"box": {
					"id": "obj-in",
					"maxclass": "inlet",
					"comment": "MIDI in (raw, from midiin)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						20.0,
						20.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"id": "obj-bars",
					"maxclass": "inlet",
					"comment": "bars (list of counts from the multislider drag)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300.0,
						20.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"id": "obj-nch",
					"maxclass": "inlet",
					"comment": "channels (int 1-16) \u2014 pool size",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						560.0,
						20.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"id": "obj-relearn",
					"maxclass": "inlet",
					"comment": "re-learn (bang) \u2014 forget all assignments; next notes re-learn from ch1",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						680.0,
						20.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"id": "obj-out",
					"maxclass": "outlet",
					"comment": "MIDI out (to midiout)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						700.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"id": "obj-disp-in",
					"maxclass": "outlet",
					"comment": "last incoming pitch (display)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						360.0,
						700.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"id": "obj-disp-ch",
					"maxclass": "outlet",
					"comment": "last assigned channel (display)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						440.0,
						700.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"id": "obj-counts",
					"maxclass": "outlet",
					"comment": "per-channel counts (to multislider)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						520.0,
						700.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"id": "obj-disp-nch",
					"maxclass": "outlet",
					"comment": "channels (to number, on restore)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						680.0,
						700.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"id": "obj-parse",
					"maxclass": "newobj",
					"text": "midiparse",
					"numinlets": 1,
					"numoutlets": 8,
					"outlettype": [
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						20.0,
						80.0,
						220.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-v8",
					"maxclass": "newobj",
					"text": "v8 arpsplit.js",
					"numinlets": 1,
					"numoutlets": 8,
					"outlettype": [
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						20.0,
						300.0,
						120.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-format",
					"maxclass": "newobj",
					"text": "midiformat",
					"numinlets": 8,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						20.0,
						620.0,
						220.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-prepend-bars",
					"maxclass": "newobj",
					"text": "prepend bars",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300.0,
						200.0,
						90.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-prepend-nch",
					"maxclass": "newobj",
					"text": "prepend channels",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						560.0,
						200.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-msg-relearn",
					"maxclass": "message",
					"text": "relearn",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						680.0,
						200.0,
						70.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-doc1",
					"maxclass": "comment",
					"text": "Notes -> channels by order of arrival, sculpted by dragging the count bars. New notes join the RIGHTMOST populated channel (1st note -> ch1). Drag a bar down to peel its newest notes off: target mode pushes them right, distribute mode levels them across the populated channels. Sticky per pitch; held notes never hang.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						260.0,
						290.0,
						380.0,
						75.0
					]
				}
			},
			{
				"box": {
					"id": "obj-doc2",
					"maxclass": "comment",
					"text": "midiparse note (outlet 0) -> v8; other voice msgs (1-5) pass straight to midiformat.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						260.0,
						110.0,
						380.0,
						30.0
					]
				}
			},
			{
				"box": {
					"id": "obj-route",
					"maxclass": "newobj",
					"text": "route 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16",
					"numinlets": 1,
					"numoutlets": 17,
					"outlettype": [
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						360.0,
						420.0,
						470.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-doc3",
					"maxclass": "comment",
					"text": "broadcast each group to a global send bus (arpsplit_ch1..16) for the arpsplit-recv devices. Names are GLOBAL: one master per Live set.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						360.0,
						380.0,
						470.0,
						30.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s1",
					"maxclass": "newobj",
					"text": "send arpsplit_ch1",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						360.0,
						470.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s2",
					"maxclass": "newobj",
					"text": "send arpsplit_ch2",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						360.0,
						496.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s3",
					"maxclass": "newobj",
					"text": "send arpsplit_ch3",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						360.0,
						522.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s4",
					"maxclass": "newobj",
					"text": "send arpsplit_ch4",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						360.0,
						548.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s5",
					"maxclass": "newobj",
					"text": "send arpsplit_ch5",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						480.0,
						470.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s6",
					"maxclass": "newobj",
					"text": "send arpsplit_ch6",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						480.0,
						496.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s7",
					"maxclass": "newobj",
					"text": "send arpsplit_ch7",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						480.0,
						522.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s8",
					"maxclass": "newobj",
					"text": "send arpsplit_ch8",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						480.0,
						548.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s9",
					"maxclass": "newobj",
					"text": "send arpsplit_ch9",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						600.0,
						470.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s10",
					"maxclass": "newobj",
					"text": "send arpsplit_ch10",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						600.0,
						496.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s11",
					"maxclass": "newobj",
					"text": "send arpsplit_ch11",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						600.0,
						522.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s12",
					"maxclass": "newobj",
					"text": "send arpsplit_ch12",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						600.0,
						548.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s13",
					"maxclass": "newobj",
					"text": "send arpsplit_ch13",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						720.0,
						470.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s14",
					"maxclass": "newobj",
					"text": "send arpsplit_ch14",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						720.0,
						496.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s15",
					"maxclass": "newobj",
					"text": "send arpsplit_ch15",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						720.0,
						522.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-s16",
					"maxclass": "newobj",
					"text": "send arpsplit_ch16",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						720.0,
						548.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-statein",
					"maxclass": "inlet",
					"comment": "state-in (from pattr, on load) -> setstate",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						800.0,
						20.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"id": "obj-stateout",
					"maxclass": "outlet",
					"comment": "state-out (to pattr arpsplit_state)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						760.0,
						700.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"id": "obj-prepend-setstate",
					"maxclass": "newobj",
					"text": "prepend setstate",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						800.0,
						200.0,
						110.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-seedin",
					"maxclass": "inlet",
					"comment": "seed (bang) \u2014 DEBUG: inject fake notes to sculpt with no MIDI",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						860.0,
						20.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"id": "obj-msg-seed",
					"maxclass": "message",
					"text": "seed 8",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						860.0,
						200.0,
						60.0,
						22.0
					]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": [
						"obj-in",
						0
					],
					"destination": [
						"obj-parse",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-parse",
						0
					],
					"destination": [
						"obj-v8",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-parse",
						1
					],
					"destination": [
						"obj-format",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-parse",
						2
					],
					"destination": [
						"obj-format",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-parse",
						3
					],
					"destination": [
						"obj-format",
						3
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-parse",
						4
					],
					"destination": [
						"obj-format",
						4
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-parse",
						5
					],
					"destination": [
						"obj-format",
						5
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-v8",
						1
					],
					"destination": [
						"obj-format",
						7
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-v8",
						0
					],
					"destination": [
						"obj-format",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-v8",
						2
					],
					"destination": [
						"obj-disp-in",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-v8",
						3
					],
					"destination": [
						"obj-disp-ch",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-v8",
						4
					],
					"destination": [
						"obj-counts",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-v8",
						6
					],
					"destination": [
						"obj-disp-nch",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-format",
						0
					],
					"destination": [
						"obj-out",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-bars",
						0
					],
					"destination": [
						"obj-prepend-bars",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-prepend-bars",
						0
					],
					"destination": [
						"obj-v8",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-nch",
						0
					],
					"destination": [
						"obj-prepend-nch",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-prepend-nch",
						0
					],
					"destination": [
						"obj-v8",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-relearn",
						0
					],
					"destination": [
						"obj-msg-relearn",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-msg-relearn",
						0
					],
					"destination": [
						"obj-v8",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-v8",
						5
					],
					"destination": [
						"obj-route",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						0
					],
					"destination": [
						"obj-s1",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						1
					],
					"destination": [
						"obj-s2",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						2
					],
					"destination": [
						"obj-s3",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						3
					],
					"destination": [
						"obj-s4",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						4
					],
					"destination": [
						"obj-s5",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						5
					],
					"destination": [
						"obj-s6",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						6
					],
					"destination": [
						"obj-s7",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						7
					],
					"destination": [
						"obj-s8",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						8
					],
					"destination": [
						"obj-s9",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						9
					],
					"destination": [
						"obj-s10",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						10
					],
					"destination": [
						"obj-s11",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						11
					],
					"destination": [
						"obj-s12",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						12
					],
					"destination": [
						"obj-s13",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						13
					],
					"destination": [
						"obj-s14",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						14
					],
					"destination": [
						"obj-s15",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-route",
						15
					],
					"destination": [
						"obj-s16",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-statein",
						0
					],
					"destination": [
						"obj-prepend-setstate",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-prepend-setstate",
						0
					],
					"destination": [
						"obj-v8",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-v8",
						7
					],
					"destination": [
						"obj-stateout",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-seedin",
						0
					],
					"destination": [
						"obj-msg-seed",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-msg-seed",
						0
					],
					"destination": [
						"obj-v8",
						0
					]
				}
			}
		]
	}
}
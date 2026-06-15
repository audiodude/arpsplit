{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 4,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 1877.0, 778.0, 1238.0, 869.0 ],
        "boxes": [
            {
                "box": {
                    "id": "obj-help",
                    "linecount": 3,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 20.0, 20.0, 330.0, 47.0 ],
                    "text": "arpsplit-recv device content. Open, Select All, Copy, Paste into a Max MIDI Effect. Connect to the device's own midiout (or use this one). live.numbox 'Group' saves with the set."
                }
            },
            {
                "box": {
                    "id": "obj-lbl",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 135.0, 72.5, 133.0, 20.0 ],
                    "text": "Group/\"Channel\"(1-16)"
                }
            },
            {
                "box": {
                    "fontsize": 20.0,
                    "id": "obj-grp",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 20.0, 69.0, 100.0, 27.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 1 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Group",
                            "parameter_mmax": 16.0,
                            "parameter_mmin": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Group",
                            "parameter_type": 1,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "Group"
                }
            },
            {
                "box": {
                    "id": "obj-recv",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 20.0, 108.0, 100.0, 22.0 ],
                    "text": "arpsplit-recv"
                }
            },
            {
                "box": {
                    "id": "obj-midiout",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 20.0, 143.0, 100.0, 22.0 ],
                    "text": "midiout"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-recv", 0 ],
                    "source": [ "obj-grp", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-midiout", 0 ],
                    "source": [ "obj-recv", 0 ]
                }
            }
        ],
        "parameters": {
            "obj-grp": [ "Group", "Group", 0 ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [ "-", "-", "-", "-", "-", "-", "-", "-" ],
                    "buttons": [ "-", "-", "-", "-", "-", "-", "-", "-" ]
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0,
        "oscreceiveudpport": 0
    }
}
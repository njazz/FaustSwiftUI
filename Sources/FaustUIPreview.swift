//
//  FaustUIPreview.swift
//  FaustSwiftUI
//
//  Created by alex on 23/03/2025.
//

import SwiftUI

struct FaustUIView_Preview: PreviewProvider {
    
    static var previews: some View {
        var json: [FaustUI] = []
        
        let testJSON = #"""
[ 
        {
            "type": "tgroup",
            "label": "grp 1",
            "items": [ 
                {
                    "type": "hgroup",
                    "label": "hmisc",
                    "items": [ 
                        {
                            "type": "button",
                            "label": "button",
                            "varname": "fButton1",
                            "shortname": "hmisc_button",
                            "address": "/grp_1/hmisc/button"
                        },
                        {
                            "type": "hbargraph",
                            "label": "hbar",
                            "varname": "fHbargraph1",
                            "shortname": "hmisc_hbar",
                            "address": "/grp_1/hmisc/hbar",
                            "min": 0,
                            "max": 127
                        },
                        {
                            "type": "hslider",
                            "label": "hslider",
                            "varname": "fHslider1",
                            "shortname": "hmisc_hslider",
                            "address": "/grp_1/hmisc/hslider",
                            "init": 60,
                            "min": 0,
                            "max": 127,
                            "step": 0.1
                        },
                        {
                            "type": "nentry",
                            "label": "num",
                            "varname": "fEntry4",
                            "shortname": "num",
                            "address": "/grp_1/hmisc/num",
                            "meta": [
                                { "unit": "f" }
                            ],
                            "init": 60,
                            "min": 0,
                            "max": 127,
                            "step": 0.1
                        },
                        {
                            "type": "vbargraph",
                            "label": "vbar",
                            "varname": "fVbargraph3",
                            "shortname": "vbar",
                            "address": "/grp_1/hmisc/vbar",
                            "min": 0,
                            "max": 127
                        },
                        {
                            "type": "vslider",
                            "label": "vslider4",
                            "varname": "fVslider16",
                            "shortname": "hmisc_vslider4",
                            "address": "/grp_1/hmisc/vslider4",
                            "meta": [
                                { "unit": "f" }
                            ],
                            "init": 60,
                            "min": 0,
                            "max": 127,
                            "step": 0.1
                        }
                    ]
                },
                {
                    "type": "hgroup",
                    "label": "knobs",
                    "items": [ 
                        {
                            "type": "vslider",
                            "label": "knob1",
                            "varname": "fVslider3",
                            "shortname": "knob1",
                            "address": "/grp_1/knobs/knob1",
                            "meta": [
                                { "style": "knob" }
                            ],
                            "init": 60,
                            "min": 0,
                            "max": 127,
                            "step": 0.1
                        },
                        {
                            "type": "vslider",
                            "label": "knob2",
                            "varname": "fVslider4",
                            "shortname": "knob2",
                            "address": "/grp_1/knobs/knob2",
                            "meta": [
                                { "style": "knob" }
                            ],
                            "init": 60,
                            "min": 0,
                            "max": 127,
                            "step": 0.1
                        },
                        {
                            "type": "vslider",
                            "label": "knob3",
                            "varname": "fVslider5",
                            "shortname": "knob3",
                            "address": "/grp_1/knobs/knob3",
                            "meta": [
                                { "style": "knob" }
                            ],
                            "init": 60,
                            "min": 0,
                            "max": 127,
                            "step": 0.1
                        }
                    ]
                },
                {
                    "type": "hgroup",
                    "label": "sliders",
                    "items": [ 
                        {
                            "type": "vslider",
                            "label": "vslider1",
                            "varname": "fVslider0",
                            "shortname": "vslider1",
                            "address": "/grp_1/sliders/vslider1",
                            "init": 60,
                            "min": 0,
                            "max": 127,
                            "step": 0.1
                        },
                        {
                            "type": "vslider",
                            "label": "vslider2",
                            "varname": "fVslider1",
                            "shortname": "vslider2",
                            "address": "/grp_1/sliders/vslider2",
                            "init": 60,
                            "min": 0,
                            "max": 127,
                            "step": 0.1
                        },
                        {
                            "type": "vslider",
                            "label": "vslider3",
                            "varname": "fVslider2",
                            "shortname": "vslider3",
                            "address": "/grp_1/sliders/vslider3",
                            "init": 60,
                            "min": 0,
                            "max": 127,
                            "step": 0.1
                        }
                    ]
                },
                {
                    "type": "vgroup",
                    "label": "vbox",
                    "items": [ 
                        {
                            "type": "checkbox",
                            "label": "check1",
                            "varname": "fCheckbox0",
                            "shortname": "check1",
                            "address": "/grp_1/vbox/check1"
                        },
                        {
                            "type": "checkbox",
                            "label": "check2",
                            "varname": "fCheckbox1",
                            "shortname": "check2",
                            "address": "/grp_1/vbox/check2"
                        },
                        {
                            "type": "nentry",
                            "label": "knob0",
                            "varname": "fEntry0",
                            "shortname": "knob0",
                            "address": "/grp_1/vbox/knob0",
                            "meta": [
                                { "style": "knob" }
                            ],
                            "init": 60,
                            "min": 0,
                            "max": 127,
                            "step": 0.1
                        }
                    ]
                },
                {
                    "type": "vgroup",
                    "label": "vmisc",
                    "items": [ 
                        {
                            "type": "button",
                            "label": "button",
                            "varname": "fButton0",
                            "shortname": "vmisc_button",
                            "address": "/grp_1/vmisc/button"
                        },
                        {
                            "type": "hbargraph",
                            "label": "hbar",
                            "varname": "fHbargraph0",
                            "shortname": "vmisc_hbar",
                            "address": "/grp_1/vmisc/hbar",
                            "min": 0,
                            "max": 127
                        },
                        {
                            "type": "hslider",
                            "label": "hslider",
                            "varname": "fHslider0",
                            "shortname": "vmisc_hslider",
                            "address": "/grp_1/vmisc/hslider",
                            "meta": [
                                { "unit": "Hz" }
                            ],
                            "init": 60,
                            "min": 0,
                            "max": 127,
                            "step": 0.1
                        },
                        {
                            "type": "hgroup",
                            "label": "small box 1",
                            "items": [ 
                                {
                                    "type": "vslider",
                                    "label": "knob4",
                                    "varname": "fVslider9",
                                    "shortname": "knob4",
                                    "address": "/grp_1/vmisc/small_box_1/knob4",
                                    "meta": [
                                        { "style": "knob" }
                                    ],
                                    "init": 60,
                                    "min": 0,
                                    "max": 127,
                                    "step": 0.1
                                },
                                {
                                    "type": "nentry",
                                    "label": "num1",
                                    "varname": "fEntry1",
                                    "shortname": "num1",
                                    "address": "/grp_1/vmisc/small_box_1/num1",
                                    "meta": [
                                        { "unit": "f" }
                                    ],
                                    "init": 60,
                                    "min": 0,
                                    "max": 127,
                                    "step": 0.1
                                },
                                {
                                    "type": "vbargraph",
                                    "label": "vbar1",
                                    "varname": "fVbargraph0",
                                    "shortname": "vbar1",
                                    "address": "/grp_1/vmisc/small_box_1/vbar1",
                                    "min": 0,
                                    "max": 127
                                },
                                {
                                    "type": "vslider",
                                    "label": "vslider5",
                                    "varname": "fVslider7",
                                    "shortname": "vslider5",
                                    "address": "/grp_1/vmisc/small_box_1/vslider5",
                                    "meta": [
                                        { "unit": "Hz" }
                                    ],
                                    "init": 60,
                                    "min": 0,
                                    "max": 127,
                                    "step": 0.1
                                },
                                {
                                    "type": "vslider",
                                    "label": "vslider6",
                                    "varname": "fVslider8",
                                    "shortname": "vslider6",
                                    "address": "/grp_1/vmisc/small_box_1/vslider6",
                                    "meta": [
                                        { "unit": "Hz" }
                                    ],
                                    "init": 60,
                                    "min": 0,
                                    "max": 127,
                                    "step": 0.1
                                }
                            ]
                        },
                        {
                            "type": "hgroup",
                            "label": "sub box 1",
                            "items": [ 
                                {
                                    "type": "hgroup",
                                    "label": "small box 2",
                                    "items": [ 
                                        {
                                            "type": "vslider",
                                            "label": "knob5",
                                            "varname": "fVslider12",
                                            "shortname": "knob5",
                                            "address": "/grp_1/vmisc/sub_box_1/small_box_2/knob5",
                                            "meta": [
                                                { "style": "knob" }
                                            ],
                                            "init": 60,
                                            "min": 0,
                                            "max": 127,
                                            "step": 0.1
                                        },
                                        {
                                            "type": "nentry",
                                            "label": "num2",
                                            "varname": "fEntry2",
                                            "shortname": "num2",
                                            "address": "/grp_1/vmisc/sub_box_1/small_box_2/num2",
                                            "meta": [
                                                { "unit": "f" }
                                            ],
                                            "init": 60,
                                            "min": 0,
                                            "max": 127,
                                            "step": 0.1
                                        },
                                        {
                                            "type": "vbargraph",
                                            "label": "vbar2",
                                            "varname": "fVbargraph1",
                                            "shortname": "vbar2",
                                            "address": "/grp_1/vmisc/sub_box_1/small_box_2/vbar2",
                                            "min": 0,
                                            "max": 127
                                        },
                                        {
                                            "type": "vslider",
                                            "label": "vslider7",
                                            "varname": "fVslider10",
                                            "shortname": "vslider7",
                                            "address": "/grp_1/vmisc/sub_box_1/small_box_2/vslider7",
                                            "meta": [
                                                { "unit": "Hz" }
                                            ],
                                            "init": 60,
                                            "min": 0,
                                            "max": 127,
                                            "step": 0.1
                                        },
                                        {
                                            "type": "vslider",
                                            "label": "vslider8",
                                            "varname": "fVslider11",
                                            "shortname": "vslider8",
                                            "address": "/grp_1/vmisc/sub_box_1/small_box_2/vslider8",
                                            "meta": [
                                                { "unit": "Hz" }
                                            ],
                                            "init": 60,
                                            "min": 0,
                                            "max": 127,
                                            "step": 0.1
                                        }
                                    ]
                                },
                                {
                                    "type": "hgroup",
                                    "label": "small box 3",
                                    "items": [ 
                                        {
                                            "type": "vslider",
                                            "label": "knob6",
                                            "varname": "fVslider15",
                                            "shortname": "knob6",
                                            "address": "/grp_1/vmisc/sub_box_1/small_box_3/knob6",
                                            "meta": [
                                                { "style": "knob" }
                                            ],
                                            "init": 60,
                                            "min": 0,
                                            "max": 127,
                                            "step": 0.1
                                        },
                                        {
                                            "type": "nentry",
                                            "label": "num3",
                                            "varname": "fEntry3",
                                            "shortname": "num3",
                                            "address": "/grp_1/vmisc/sub_box_1/small_box_3/num3",
                                            "meta": [
                                                { "unit": "f" }
                                            ],
                                            "init": 60,
                                            "min": 0,
                                            "max": 127,
                                            "step": 0.1
                                        },
                                        {
                                            "type": "vbargraph",
                                            "label": "vbar3",
                                            "varname": "fVbargraph2",
                                            "shortname": "vbar3",
                                            "address": "/grp_1/vmisc/sub_box_1/small_box_3/vbar3",
                                            "min": 0,
                                            "max": 127
                                        },
                                        {
                                            "type": "vslider",
                                            "label": "vslider10",
                                            "varname": "fVslider14",
                                            "shortname": "vslider10",
                                            "address": "/grp_1/vmisc/sub_box_1/small_box_3/vslider10",
                                            "meta": [
                                                { "unit": "m" }
                                            ],
                                            "init": 60,
                                            "min": 0,
                                            "max": 127,
                                            "step": 0.1
                                        },
                                        {
                                            "type": "vslider",
                                            "label": "vslider9",
                                            "varname": "fVslider13",
                                            "shortname": "vslider9",
                                            "address": "/grp_1/vmisc/sub_box_1/small_box_3/vslider9",
                                            "meta": [
                                                { "unit": "Hz" }
                                            ],
                                            "init": 60,
                                            "min": 0,
                                            "max": 127,
                                            "step": 0.1
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            "type": "vslider",
                            "label": "vslider4",
                            "varname": "fVslider6",
                            "shortname": "vmisc_vslider4",
                            "address": "/grp_1/vmisc/vslider4",
                            "meta": [
                                { "unit": "Hz" }
                            ],
                            "init": 60,
                            "min": 0,
                            "max": 127,
                            "step": 0.1
                        }
                    ]
                }
            ]
        }
    ]
"""#
        
        // example
        let decoder = JSONDecoder()
        do {
            json = try decoder.decode([FaustUI].self, from: Data(testJSON.utf8))
            } catch {
                return
                    AnyView(Text("FaustUI: failed to decode JSON: \(error)")
                    .frame(minWidth: 320, minHeight: 240)
                    .previewLayout(.sizeThatFits))
            }
        
        // Use @StateObject in the preview so that the viewModel is correctly managed by SwiftUI
        let viewModel = FaustUIViewModel()
        
        // some test values added:
        viewModel.setValue(100, for: "/grp_1/hmisc/hbar")
        viewModel.setValue(64, for: "/grp_1/hmisc/hslider")
        viewModel.setValue(32, for: "/grp_1/hmisc/vbar")
        viewModel.setValue(64, for: "/grp_1/hmisc/vslider4")
        
        return AnyView(
            
            ScrollView ([.horizontal, .vertical]) {
                FaustUIView(ui: json, viewModel: viewModel)
                    .padding()
                
                    .frame(minWidth:800, maxWidth: .infinity, minHeight: 600,maxHeight: .infinity)
                    .previewLayout(.sizeThatFits)
            }
        )
    }
}

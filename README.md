# FaustSwiftUI

This is a SwiftUI-based dynamic UI renderer for Faust DSP JSON metadata. It parses the Faust UI JSON structure and displays corresponding SwiftUI controls like sliders, toggles, buttons, bargraphs etc.

## Features

- ✅ JSON-driven layout
- ✅ Live binding via `@ObservedObject` with a `FaustUIViewModel`
- ✅ Dynamic layout from `vgroup`, `hgroup`, `tgroup` primitives
- 🔄 UI-to-DSP input controls (`hslider`, `vslider`, `checkbox`, `button` ...)
- 🔄 DSP-to-UI output monitors (`hbargraph`, `vbargraph`)
- 🔄 Style metadata (`knob`, `menu`, `radio` ...)
- ❌ Load default values from JSON layout to ViewModel

## Usage

```swift
let jsonData: Data = ... // Faust UI JSON from libfaust
let ui = try JSONDecoder().decode([FaustUI].self, from: jsonData)

FaustUIView(ui: ui, viewModel: FaustUIViewModel())
```

## Supported Primitives

| Type         | Description                    | Implemented |
|--------------|--------------------------------|-------------|
| `vgroup`     | Vertical group                 | ✅          |
| `hgroup`     | Horizontal group               | ✅          |
| `tgroup`     | Tabbed group                   | ✅          |
| `hslider`    | Horizontal slider              | ✅          |
| `vslider`    | Vertical slider                | ✅          |
| `nentry`     | Number entry box               | ✅          |
| `button`     | Momentary push button          | ✅          |
| `checkbox`   | Toggle button                  | ✅          |
| `hbargraph`  | Horizontal bargraph            | ✅          |
| `vbargraph`  | Vertical bargraph              | ✅          |

## Supported Styles (via `[style:...]` metadata)

| Style         | Description                    | Implemented    |
|---------------|--------------------------------|----------------|
| `knob`        | Rotary knob                    | ✅             |
| `menu{...}`   | Dropdown menu                  | ❌             |
| `radio{...}`  | Radio button menu              | ❌             |
| `led`         | LED-style output               | ❌             |
| `numerical`   | Numerical value display        | ❌             |

## Supported Metadata

| Key        | Description           | Implemented |
|------------|-----------------------|-------------|
| `style`    | Widget style          | ✅          |
| `unit`     | Display value unit    | ❌          |
| `scale`    | Value scaling         | ❌          |
| `tooltip`  | Tooltip               | ❌          |
| `hidden`   | Hidden components     | ✅          |


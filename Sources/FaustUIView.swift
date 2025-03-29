// FaustUIView.swift

import SwiftUI

public struct FaustUIView<ViewModelType: FaustUIValueBinding>: View {
    public let ui: [FaustUI]
    @ObservedObject public var viewModel: ViewModelType

    @StateObject private var themeManager = FaustThemeManager()

    public init(ui: [FaustUI], viewModel: ViewModelType) {
        self.ui = ui
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(alignment: .leading) {
            ForEach(ui) { item in
                render(item)
            }
        }.environmentObject(themeManager)
    }
    
    private func isKnob(_ item: FaustUI) -> Bool {
        if let meta = item.meta {
            for e in meta{
                if let style = e.style {
                    if style == .knob {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    private func isHidden(_ item: FaustUI) -> Bool {
        if let meta = item.meta {
            for e in meta{
                if e.hidden == "1" { return true }
            }
        }
        return false
    }

    @ViewBuilder
    private func render(_ item: FaustUI) -> some View {
        // hidden items
        if (isHidden(item))
        {
            EmptyView()
        }
        
        // style: knob
        let isKnob = isKnob(item)
        
        if item.type == .vgroup, let items = item.items {
            GroupBox(label: Text(item.label)) {
                VStack(alignment: .leading, spacing: themeManager.theme.groupSpacing) {
                    ForEach(items) { child in
                        AnyView(render(child))
                    }
                }
            }
        }

        if item.type == .hgroup, let items = item.items {
            GroupBox(label: Text(item.label)) {
                HStack(alignment: .center, spacing: themeManager.theme.groupSpacing) {
                    ForEach(items) { child in
                        AnyView(render(child))
                    }
                }
            }
        }

        if item.type == .tgroup, let items = item.items {
            AnyView(
                GroupBox(label: Text(item.label)) {
                    TabView {
                        ForEach(items) { child in

                            VStack {
                                Text(child.label)
                                    .font(.headline)
                                render(child)
                            }.tabItem { Text(child.label) }
                        }
                    }
                }
            )
        }

        // -----
        if item.type == .vslider && !isKnob,
           let address = item.address,
           let min = item.min,
           let max = item.max,
           let step = item.step {
            FaustVSlider(label: item.label, address: address, range: min ... max, step: step, value: binding(for: address, default: min))
        }

        if item.type == .hslider && !isKnob,
           let address = item.address,
           let min = item.min,
           let max = item.max,
           let step = item.step {
            FaustHSlider(label: item.label, address: address, range: min ... max, step: step, value: binding(for: address, default: min))
        }
        
        if (item.type == .hslider || item.type == .vslider) && isKnob,
           let address = item.address,
           let min = item.min,
           let max = item.max,
           let step = item.step {
            FaustKnob(label: item.label, address: address, range: min ... max, step: step, value: binding(for: address, default: min))
        }

        // -----
        if item.type == .checkbox,
           let address = item.address {
            FaustCheckbox(label: item.label, address: address, value: binding(for: address, default: 0.0))
        }

        if item.type == .button,
           let address = item.address {
            FaustButton(label: item.label, address: address, value: binding(for: address, default: 0.0))
        }

        if item.type == .nentry,
           let address = item.address,
           let min = item.min,
           let max = item.max,
           let step = item.step {
            FaustNSwitch(label: item.label, address: address, range: min ... max, step: step, value: binding(for: address, default: min))
        }

        // -----
        if item.type == .vbargraph,
           let address = item.address {
            FaustVBargraph(label: item.label, address: address, min: item.min ?? 0.0, max: item.max ?? 1.0, value: binding(for: address, default: 0))
                .frame(idealWidth: 45, maxWidth: 45)
        }

        if item.type == .hbargraph,
           let address = item.address {
            FaustHBargraph(label: item.label, address: address, min: item.min ?? 0.0, max: item.max ?? 1.0, value: binding(for: address, default: 0))
                .frame(idealHeight: 45, maxHeight: 45)
        }

        EmptyView()
    }

    // Helper function to create bindings for values stored in the viewModel
    private func binding<T>(for address: String, default defaultValue: T) -> Binding<T> where T: BinaryFloatingPoint {
        return Binding(
            get: { T(viewModel.getValue(for: address, default: Double(defaultValue))) },
            set: { newValue in viewModel.setValue(Double(newValue), for: address) }
        )
    }

    private func binding(for address: String, default defaultValue: Bool) -> Binding<Bool> {
        return Binding(
            get: { viewModel.getValue(for: address, default: 0.0) != 0.0 },
            set: { newValue in viewModel.setValue(newValue ? 1.0 : 0.0, for: address) }
        )
    }
}

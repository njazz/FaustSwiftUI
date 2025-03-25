// FaustUIView.swift

import SwiftUI

public struct FaustUIView<ViewModelType: FaustUIValueBinding>: View {
    public let ui: [FaustUI]
    @ObservedObject public var viewModel: ViewModelType

    public init(ui: [FaustUI], viewModel: ViewModelType) {
        self.ui = ui
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(alignment: .leading) {
            ForEach(ui) { item in
                render(item)
            }
        }
    }

    @ViewBuilder
    private func render(_ item: FaustUI) -> some View {
        if [.vgroup].contains(item.type), let items = item.items {
            GroupBox(label: Text(item.label)) {
                VStack(alignment: .leading) {
                    ForEach(items) { child in
                        AnyView(render(child))
                    }
                }
            }
        }

        if [.hgroup].contains(item.type), let items = item.items {
            GroupBox(label: Text(item.label)) {
                HStack(alignment: .center) {
                    ForEach(items) { child in
                        AnyView(render(child))
                    }
                }
            }
        }

        if [.tgroup].contains(item.type), let items = item.items {
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
        if [.vslider].contains(item.type),
           let address = item.address,
           let min = item.min,
           let max = item.max,
           let step = item.step {
            FaustSlider(label: item.label, address: address, range: min ... max, step: step, viewModel: viewModel)
        }

        if [.hslider].contains(item.type),
           let address = item.address,
           let min = item.min,
           let max = item.max,
           let step = item.step {
            FaustSlider(label: item.label, address: address, range: min ... max, step: step, viewModel: viewModel)
        }
           
        // -----
        if item.type == .checkbox,
           let address = item.address {
            FaustCheckbox(label: item.label, address: address, viewModel: viewModel)
        }

        if item.type == .button,
           let address = item.address {
            FaustButton(label: item.label, address: address, viewModel: viewModel)
        }

        if item.type == .nentry,
           let address = item.address,
           let min = item.min,
           let max = item.max,
           let step = item.step {
            FaustNSwitch(label: item.label, address: address, range: min ... max, step: step, viewModel: viewModel)
        }

        // -----        
        if item.type == .vbargraph,
           let address = item.address {
            FaustVBargraph(label: item.label, address: address, min: item.min ?? 0.0, max: item.max ?? 1.0, viewModel: viewModel)
                .frame(idealWidth: 45, maxWidth: 45)
        }

        if item.type == .hbargraph,
           let address = item.address {
            FaustHBargraph(label: item.label, address: address, min: item.min ?? 0.0, max: item.max ?? 1.0, viewModel: viewModel)
                .frame(idealHeight: 45, maxHeight: 45)
        }

        EmptyView()
    }
}

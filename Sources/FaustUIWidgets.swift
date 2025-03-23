// FaustWidgets.swift

import SwiftUI

public struct FaustSlider: View {
    public let label: String
    public let address: String
    public let range: ClosedRange<Double>
    public let step: Double
    @ObservedObject public var viewModel: FaustUIViewModel

    public init(label: String, address: String, range: ClosedRange<Double>, step: Double, viewModel: FaustUIViewModel) {
        self.label = label
        self.address = address
        self.range = range
        self.step = step
        self.viewModel = viewModel
    }

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack(alignment: .leading) {
            Text(label)
                .multilineTextAlignment(.center)
            
            let value = viewModel.getValue(for: address, default: range.lowerBound)
            if (value<range.lowerBound || value > range.upperBound)
            {
                Text("Value out of range: \(viewModel.getValue(for: address, default: 0)) \(range.lowerBound) \(range.upperBound)")
                            .font(.caption)
                            .foregroundColor(.gray)
            }            
            else
            {
                HStack(){
                    Text("\(viewModel.getValue(for: address, default: 0))")
                        .frame(minWidth: 50, maxWidth: 100)
                    
                    Slider(value: Binding(
                        get: { viewModel.getValue(for: address, default: range.lowerBound) }, // Ensure it returns a Double
                        set: { viewModel.setValue($0, for: address) } // Ensure this updates the model correctly
                    ), in: range/*, step: step*/)
                    .frame(minWidth: 100, minHeight: 50)
                }
            }
        }
    }
}

// MARK: -

public struct FaustCheckbox: View {
    public let label: String
    public let address: String
    @ObservedObject public var viewModel: FaustUIViewModel

    public init(label: String, address: String, viewModel: FaustUIViewModel) {
        self.label = label
        self.address = address
        self.viewModel = viewModel
    }

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        Toggle(isOn: Binding(
            get: { viewModel.getValue(for: address) > 0.5 },
            set: { viewModel.setValue($0 ? 1.0 : 0.0, for: address) }
        )) {
            Text(label)
        }
    }
}

// MARK: -

public struct FaustButton: View {
    public let label: String
    public let address: String
    @ObservedObject public var viewModel: FaustUIViewModel

    public init(label: String, address: String, viewModel: FaustUIViewModel) {
        self.label = label
        self.address = address
        self.viewModel = viewModel
    }

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        Button(action: {
            viewModel.setValue(1.0, for: address)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                viewModel.setValue(0.0, for: address)
            }
        }) {
            Text(label)
                .padding()
                .cornerRadius(8)
        }
    }
}

// MARK: -

public struct FaustVBargraph: View {
    public let label: String
    public let address: String
    public let min: Double
    public let max: Double
    @ObservedObject public var viewModel: FaustUIViewModel

    public init(label: String, address: String, min: Double, max: Double, viewModel: FaustUIViewModel) {
        self.label = label
        self.address = address
        self.min = min
        self.max = max
        self.viewModel = viewModel
    }

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack(alignment: .leading) {
            Text(label).frame(alignment: .center)
            GeometryReader { geometry in
                let value = viewModel.getValue(for: address, default: min)
                let percent = CGFloat((value - min) / (max - min))
                ZStack(alignment: .bottom) {
                    Rectangle().fill(Color.gray.opacity(0.2))
                    Rectangle().fill(Color.green)
                        .frame(height: geometry.size.height * percent)
                }
                .cornerRadius(4)
            }
            .frame(height: 100)
        }
    }
}

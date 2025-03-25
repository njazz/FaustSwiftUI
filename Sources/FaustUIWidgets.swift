// FaustWidgets.swift

import SwiftUI

//public struct FaustSlider<ViewModelType: FaustUIValueBinding>: View {
//    public let label: String
//    public let address: String
//    public let range: ClosedRange<Double>
//    public let step: Double
//    @ObservedObject public var viewModel: ViewModelType
//
//    public init(label: String, address: String, range: ClosedRange<Double>, step: Double, viewModel: ViewModelType) {
//        self.label = label
//        self.address = address
//        self.range = range
//        self.step = step
//        self.viewModel = viewModel
//    }
//
//    public var body: some View { render }
//
//    @ViewBuilder
//    private var render: some View {
//        VStack(alignment: .leading) {
//            Text(label)
//                .multilineTextAlignment(.center)
//            
//            let value = viewModel.getValue(for: address, default: range.lowerBound)
//            if (value<range.lowerBound || value > range.upperBound)
//            {
//                Text("Value out of range: \(viewModel.getValue(for: address, default: 0)) \(range.lowerBound) \(range.upperBound)")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//            }            
//            else
//            {
//                HStack(){
//                    Text("\(viewModel.getValue(for: address, default: 0))")
//                        .frame(minWidth: 50, maxWidth: 100)
//                    
//                    Slider(value: Binding(
//                        get: { viewModel.getValue(for: address, default: range.lowerBound) }, // Ensure it returns a Double
//                        set: { viewModel.setValue($0, for: address) } // Ensure this updates the model correctly
//                    ), in: range/*, step: step*/)
//                    .frame(minWidth: 100, minHeight: 50)
//                }
//            }
//        }
//    }
//}

// MARK: -

public struct FaustCheckbox<ViewModelType: FaustUIValueBinding>: View {
    public let label: String
    public let address: String
    @ObservedObject public var viewModel: ViewModelType

    public init(label: String, address: String, viewModel: ViewModelType) {
        self.label = label
        self.address = address
        self.viewModel = viewModel
    }

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        Toggle(isOn: Binding(
            get: { viewModel.getValue(for: address, default: 0.0) > 0.5 },
            set: { viewModel.setValue($0 ? 1.0 : 0.0, for: address) }
        )) {
            Text(label)
        }
    }
}

// MARK: -

public struct FaustButton<ViewModelType: FaustUIValueBinding>: View {
    public let label: String
    public let address: String
    @ObservedObject public var viewModel: ViewModelType

    public init(label: String, address: String, viewModel: ViewModelType) {
        self.label = label
        self.address = address
        self.viewModel = viewModel
    }

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack() {
            Text("").frame(height: 25)
            
            Button(action: {
                viewModel.setValue(1.0, for: address)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    viewModel.setValue(0.0, for: address)
                }
            }) {
                Text(label)
                    .padding()
                    .cornerRadius(8)
                    .frame(height: 25)
            }
            .frame(height:25)
            
            Text("").frame(height: 25)
        }
        .frame(height:50)
    }
}

// MARK: -

public struct FaustVBargraph<ViewModelType: FaustUIValueBinding>: View {
    public let label: String
    public let address: String
    public let min: Double
    public let max: Double
    @ObservedObject public var viewModel: ViewModelType

    public init(label: String, address: String, min: Double, max: Double, viewModel: ViewModelType) {
        self.label = label
        self.address = address
        self.min = min
        self.max = max
        self.viewModel = viewModel
    }

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack(alignment: .center) {
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
            .frame(width: 25)
        }
        .frame(width:50)
    }
}

// MARK: -

public struct FaustHBargraph<ViewModelType: FaustUIValueBinding>: View {
    public let label: String
    public let address: String
    public let min: Double
    public let max: Double
    @ObservedObject public var viewModel: ViewModelType

    public init(label: String, address: String, min: Double, max: Double, viewModel: ViewModelType) {
        self.label = label
        self.address = address
        self.min = min
        self.max = max
        self.viewModel = viewModel
    }

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack(alignment: .center) {
            Text(label).frame(height:25)
            
            GeometryReader { geometry in
                let value = viewModel.getValue(for: address, default: min)
                let percent = CGFloat((value - min) / (max - min))
                ZStack(alignment: .leading) {
                    Rectangle().fill(Color.gray.opacity(0.2))
                    Rectangle().fill(Color.green)
                        .frame(width: geometry.size.width * percent)
                }
                .cornerRadius(4)
                .frame(height:25)
            }
            .frame(height: 25)
            
            Text("").frame(height:25)
        }
    }
}

// MARK: -

struct FaustNSwitch<ViewModelType: FaustUIValueBinding>: View {
    public let label: String
    public let address: String
    let range: ClosedRange<Double>
    let step: Double
    @ObservedObject public var viewModel: ViewModelType
    
    @State private var text: String

    public init(label: String, address: String, range: ClosedRange<Double>, step: Double, viewModel: ViewModelType) {
        self.label = label
        self.address = address
        self.range = range
        self.step = step
        self.viewModel = viewModel
        
        let value = viewModel.getValue(for: address, default: range.lowerBound)
        self._text = State(initialValue: String(value))
    }

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack(alignment: .center) {
            Text(label)
                .multilineTextAlignment(.center)
                .frame(height:25)
            
            TextField("Enter a number", text: $text)
            // .keyboardType(.decimalPad)
                .onChange(of: text) { newValue in
                    var filtered = ""
                    var hasDecimalPoint = false
                    
                    for (i, char) in newValue.enumerated() {
                        if char.isWholeNumber {
                            filtered.append(char)
                        } else if char == "." && !hasDecimalPoint {
                            if i == 0 || newValue[newValue.index(newValue.startIndex, offsetBy: i - 1)].isWholeNumber {
                                filtered.append(char)
                            } else {
                                filtered = "0."
                            }
                            hasDecimalPoint = true
                        }
                    }
                    
                    if filtered != newValue {
                        text = filtered
                    }
                    
                    if let floatVal = Double(filtered) {
                        let value = floatVal
                        viewModel.setValue(value, for: address )
                    }
                }
                .textFieldStyle(SquareBorderTextFieldStyle())
                .frame(width: 50, height: 25)

        }
    }
}

// MARK: -

struct FaustHSlider<ViewModelType: FaustUIValueBinding>: View {
    public let label: String
    public let address: String
    let range: ClosedRange<Double>
    let step: Double
    @ObservedObject public var viewModel: ViewModelType
    
    @State private var isDragging = false
    @GestureState private var dragOffset: CGSize = .zero
    
    public init(label: String, address: String, range: ClosedRange<Double>, step: Double, viewModel: ViewModelType) {
        self.label = label
        self.address = address
        self.range = range
        self.step = step
        self.viewModel = viewModel
    }
    
    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack(alignment: .center) {
            Text(label)
                .multilineTextAlignment(.center)
                .frame(height:25)
            
            let value = viewModel.getValue(for: address, default: range.lowerBound)
            if (value<range.lowerBound || value > range.upperBound)
            {
                Text("Value out of range: \(viewModel.getValue(for: address, default: 0)) \(range.lowerBound) \(range.upperBound)")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .cornerRadius(0)
                            
            }
            else
            {
                HStack(){

                    Text(String(format:"%.1f",viewModel.getValue(for: address, default: 0)))
                        .frame(height:25)
                        .frame(minWidth: 50, maxWidth: 100)
                        .border(.black,width: 1)
                    
                    GeometryReader { geo in
                        let value = viewModel.getValue(for: address, default: range.lowerBound)
                        
                        let height = geo.size.height
                        let width = geo.size.width
                        let trackHeight = height * 0.25
                        let handleWidth = height * 0.33
                        // let totalSteps = (range.upperBound - range.lowerBound) / step
                        let normalized = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
                        let handleX = normalized * (width - handleWidth)
                        
                        ZStack(alignment: .leading) {
                            // Track
                            RoundedRectangle(cornerRadius: trackHeight / 2)
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: trackHeight)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, (height - trackHeight) / 2)
                            
                            // Handle
                            RoundedRectangle(cornerRadius: handleWidth / 2)
                                .fill(isDragging ? Color.accentColor : Color.primary.opacity(0.2))
                                .overlay(
                                    RoundedRectangle(cornerRadius: handleWidth / 2)
                                        .stroke(Color.accentColor, lineWidth: 2)
                                )
                                .frame(width: handleWidth, height: height)
                                .position(x: handleX + handleWidth / 2, y: height / 2)
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { gesture in
                                            isDragging = true
                                            let location = gesture.location.x
                                            let clamped = min(max(location - handleWidth / 2, 0), width - handleWidth)
                                            let percent = clamped / (width - handleWidth)
                                            let stepped = (Double(percent) * (range.upperBound - range.lowerBound) / step).rounded() * step + range.lowerBound
                                            
                                            let value = min(max(stepped, range.lowerBound), range.upperBound)
                                            viewModel.setValue(value, for: address )
                                        }
                                        .onEnded { _ in
                                            isDragging = false
                                        }
                                )
                        }
                        .contentShape(Rectangle())
                        .onTapGesture(count: 2) {
                            // Reset on double-click
                            let mid = (range.lowerBound + range.upperBound) / 2
                            
                            let value = (mid / step).rounded() * step
                            viewModel.setValue(value, for: address )
                        }
                    }
                    .frame(width:200, height: 50)
                }
            }
        }
        
        
    }
}

// MARK: -

struct FaustVSlider<ViewModelType: FaustUIValueBinding>: View {
    public let label: String
    public let address: String
    let range: ClosedRange<Double>
    let step: Double
    @ObservedObject public var viewModel: ViewModelType

    @State private var isDragging = false
    @GestureState private var dragOffset: CGSize = .zero
    
    public init(label: String, address: String, range: ClosedRange<Double>, step: Double, viewModel: ViewModelType) {
        self.label = label
        self.address = address
        self.range = range
        self.step = step
        self.viewModel = viewModel
    }
    
    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        
        VStack(alignment: .center) {
            Text(label)
                .multilineTextAlignment(.center)
            
            let value = viewModel.getValue(for: address, default: range.lowerBound)
            if (value<range.lowerBound || value > range.upperBound)
            {
                Text("Value out of range: \(viewModel.getValue(for: address, default: 0)) \(range.lowerBound) \(range.upperBound)")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .cornerRadius(0)
                
            }
            else
            {
//                VStack(){
                    
                    GeometryReader { geo in
                        let value = viewModel.getValue(for: address, default: range.lowerBound)
                        
                        let width = geo.size.width
                        let height = geo.size.height
                        let trackWidth = width * 0.25
                        let handleHeight = width * 0.33
                        // let totalSteps = (range.upperBound - range.lowerBound) / step
                        let normalized = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
                        let handleY = (1.0 - normalized) * (height - handleHeight)
                        
                        ZStack(alignment: .top) {
                            // Track
                            RoundedRectangle(cornerRadius: trackWidth / 2)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: trackWidth)
                                .frame(maxHeight: .infinity)
                                .padding(.horizontal, (width - trackWidth) / 2)
                            
                            // Handle
                            RoundedRectangle(cornerRadius: handleHeight / 2)
                                .fill(isDragging ? Color.accentColor : Color.primary.opacity(0.2))
                                .overlay(
                                    RoundedRectangle(cornerRadius: handleHeight / 2)
                                        .stroke(Color.accentColor, lineWidth: 2)
                                )
                                .frame(width: width, height: handleHeight)
                                .position(x: width / 2, y: handleY + handleHeight / 2)
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { gesture in
                                            isDragging = true
                                            let location = gesture.location.y
                                            let clamped = min(max(location - handleHeight / 2, 0), height - handleHeight)
                                            let percent = 1.0 - (clamped / (height - handleHeight))
                                            let stepped = (Double(percent) * (range.upperBound - range.lowerBound) / step).rounded() * step + range.lowerBound
                                            
                                            let value = min(max(stepped, range.lowerBound), range.upperBound)
                                            viewModel.setValue(value, for: address )
                                        }
                                        .onEnded { _ in
                                            isDragging = false
                                        }
                                )
                        }
                        .contentShape(Rectangle())
                        .onTapGesture(count: 2) {
                            let mid = (range.lowerBound + range.upperBound) / 2
                            
                            let value = (mid / step).rounded() * step
                            viewModel.setValue(value, for: address )
                        }
                    }
                    .frame(width: 50, height: 200)
                    
                    HStack() {
                        Text(String(format:"%.1f",viewModel.getValue(for: address, default: 0)))
                            .frame(minWidth: 50, maxWidth: 100)
                            .cornerRadius(0).padding()
                    }.frame(minWidth: 50, maxWidth: 50, maxHeight: 25).border(.black,width: 1)
                    
//                }
                
                
            }
        }
    }
}

// MARK: -

struct FaustKnob<ViewModelType: FaustUIValueBinding>: View {
    public let label: String
    public let address: String
    public let range: ClosedRange<Double>
    public let step: Double
    @ObservedObject public var viewModel: ViewModelType
    
    private let thickness: CGFloat = 12.0
    private let totalAngle: Angle = .degrees(315)
    private let startAngle: Angle = .degrees(112.5) // leaves 45° gap at bottom
    
    public init(label: String, address: String, range: ClosedRange<Double>, step: Double, viewModel: ViewModelType) {
        self.label = label
        self.address = address
        self.range = range
        self.step = step
        self.viewModel = viewModel
    }
    
    public var body: some View { render }
    
    @ViewBuilder
    private var render: some View {
        GeometryReader { geometry in
            let value = viewModel.getValue(for: address, default: range.lowerBound)
            
            let size = min(geometry.size.width, geometry.size.height)
            let center = CGPoint(x: size / 2, y: size / 2)
            let radius = (size - thickness) / 2
            let angle = totalAngle.radians * Double(value)
            let endAngle = startAngle + Angle(radians: angle)
            
            ZStack {
                // Background fill
                Circle()
                    .fill(Color.gray.opacity(0.2))
                
                // Arc
                Path { path in
                    path.addArc(
                        center: center,
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: false
                    )
                }
                .stroke(Color.accentColor, style: StrokeStyle(lineWidth: thickness, lineCap: .round))
            }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        let vector = CGVector(dx: gesture.location.x - center.x,
                                              dy: gesture.location.y - center.y)
                        let angle = atan2(vector.dy, vector.dx) + .pi / 2
                        var normalized = (angle < 0 ? angle + 2 * .pi : angle) / (2 * .pi)
                        
                        // Map to 315 degrees range (-157.5° to +157.5°)
                        normalized = (normalized - 0.125).truncatingRemainder(dividingBy: 0.875)
                        if normalized < 0 { normalized += 0.875 }
                        
                        let value = Double(normalized / 0.875)
                        viewModel.setValue(value, for: address )
                    }
            )
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

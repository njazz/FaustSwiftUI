// FaustWidgets.swift

import SwiftUI

// MARK: -

public struct FaustCheckbox: View {
    public let label: String
    public let address: String
    @Binding var value: Double

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        Toggle(isOn: Binding(
            get: { value > 0.5  },
            set: { value = $0 ? 1.0 : 0.0  }
        )) {
            Text(label)
        }
    }
}

// MARK: -

public struct FaustButton: View {
    public let label: String
    public let address: String
    @Binding var value: Double

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack {
            Text("").frame(height: 25)

            Button(action: {
                value = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    value = 0.0
                }
            }) {
                Text(label)
                    .padding()
                    .cornerRadius(8)
                    .frame(height: 25)
            }
            .frame(height: 25)

            Text("").frame(height: 25)
        }
        .frame(height: 50)
    }
}

// MARK: -

public struct FaustVBargraph: View {
    public let label: String
    public let address: String
    public let min: Double
    public let max: Double
    @Binding var value: Double

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack(alignment: .center) {
            Text(label).frame(alignment: .center)
            GeometryReader { geometry in
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
        .frame(width: 50)
    }
}

// MARK: -

public struct FaustHBargraph: View {
    public let label: String
    public let address: String
    public let min: Double
    public let max: Double
    @Binding var value: Double

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack(alignment: .center) {
            Text(label).frame(height: 25)

            GeometryReader { geometry in
                let percent = CGFloat((value - min) / (max - min))
                ZStack(alignment: .leading) {
                    Rectangle().fill(Color.gray.opacity(0.2))
                    Rectangle().fill(Color.green)
                        .frame(width: geometry.size.width * percent)
                }
                .cornerRadius(4)
                .frame(height: 25)
            }
            .frame(height: 25)

            Text("").frame(height: 25)
        }
    }
}

// MARK: -

struct FaustNSwitch: View {
    public let label: String
    public let address: String
    let range: ClosedRange<Double>
    let step: Double
    @Binding var value: Double

    @State private var text: String

    public init(label: String, address: String, range: ClosedRange<Double>, step: Double, value: Binding<Double>) {
        self.label = label
        self.address = address
        self.range = range
        self.step = step
        self._value = value

        _text = State(initialValue: String(value.wrappedValue))
    }

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack(alignment: .center) {
            Text(label)
                .multilineTextAlignment(.center)
                .frame(height: 25)

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
                        value = floatVal
                    }
                }
                .textFieldStyle(SquareBorderTextFieldStyle())
                .frame(width: 50, height: 25)
        }
    }
}

// MARK: -

struct FaustHSlider: View {
    public let label: String
    public let address: String
    let range: ClosedRange<Double>
    let step: Double

    @Binding var value: Double

    @State private var isDragging = false
    @GestureState private var dragOffset: CGSize = .zero

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {

        VStack(alignment: .center) {
            Text(label)
                .multilineTextAlignment(.center)
                .frame(height: 25)

            if value < range.lowerBound || value > range.upperBound {
                Text("Value out of range: \(value) \(range.lowerBound) \(range.upperBound)")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .cornerRadius(0)
            } else {
                HStack {
                    Text(String(format: "%.1f", value))
                        .frame(height: 25)
                        .frame(minWidth: 50, maxWidth: 100)
                        .border(.black, width: 1)

                    GeometryReader { geo in
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

                                            value = min(max(stepped, range.lowerBound), range.upperBound)
                                        }
                                        .onEnded { _ in
                                            isDragging = false
                                        }
                                )
                        }
                        .onTapGesture(count: 2) {
                            // Reset on double-click
                            let mid = (range.lowerBound + range.upperBound) / 2

                            value = (mid / step).rounded() * step
                        }
                    }
                    .frame(width: 200, height: 50)
                }
            }
        }
    }
}

// MARK: -

struct FaustVSlider: View {
    public let label: String
    public let address: String
    let range: ClosedRange<Double>
    let step: Double
    @Binding var value: Double

    @State private var isDragging = false
    @GestureState private var dragOffset: CGSize = .zero

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack(alignment: .center) {
            Text(label)
                .multilineTextAlignment(.center)

            if value < range.lowerBound || value > range.upperBound {
                Text("Value out of range: \(value) \(range.lowerBound) \(range.upperBound)")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .cornerRadius(0)
            } else {

                GeometryReader { geo in

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

                                        value = min(max(stepped, range.lowerBound), range.upperBound)
                                    }
                                    .onEnded { _ in
                                        isDragging = false
                                    }
                            )
                    }
                    .contentShape(Rectangle())
                    .onTapGesture(count: 2) {
                        let mid = (range.lowerBound + range.upperBound) / 2

                        value = (mid / step).rounded() * step
                    }
                }
                .frame(width: 50, height: 200)

                HStack {
                    Text(String(format: "%.1f", value))
                        .frame(minWidth: 50, maxWidth: 100)
                        .cornerRadius(0).padding()
                }.frame(minWidth: 50, maxWidth: 50, maxHeight: 25).border(.black, width: 1)

            }
        }
    }
}

// MARK: -

struct FaustKnob: View {
    public let label: String
    public let address: String
    public let range: ClosedRange<Double>
    public let step: Double
    @Binding var value: Double

    private let thickness: CGFloat = 12.0
    private let totalAngle: Angle = .degrees(315)
    private let startAngle: Angle = .degrees(112.5) // leaves 45° gap at bottom

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        GeometryReader { geometry in
            
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

                        value = Double(normalized / 0.875)
                    }
            )
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

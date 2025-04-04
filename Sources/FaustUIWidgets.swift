// FaustWidgets.swift

import SwiftUI

// MARK: -

public struct FaustCheckbox: View {
    public let label: String
    public let address: String
    @Binding var value: Double
    @EnvironmentObject var themeManager: FaustThemeManager

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack {
            Toggle(isOn: Binding(
                get: { value > 0.5 },
                set: { value = $0 ? 1.0 : 0.0 }
            )) {
                Text(label)
            }
            .frame(minHeight: themeManager.theme.labelSize, maxHeight: themeManager.theme.labelSize * 2)
//            .padding(.leading, themeManager.theme.padding)
//            .padding(.trailing, themeManager.theme.padding)
//                    .border(.black, width: 1)
        }
        .padding(.leading, themeManager.theme.padding)
        .padding(.trailing, themeManager.theme.padding)
        .frame(height: themeManager.theme.labelSize)
    }
}

// MARK: -

public struct FaustButton: View {
    public let label: String
    public let address: String
    @Binding var value: Double
    @EnvironmentObject var themeManager: FaustThemeManager

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                value = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    value = 0.0
                }
            }) {
                Text(label)
                    .padding()
                    .cornerRadius(themeManager.theme.cornerRadius)
                    .frame(height: themeManager.theme.labelSize - 2)
            }
            .frame(height: themeManager.theme.labelSize)
        }
        .padding(.leading, themeManager.theme.padding)
        .padding(.trailing, themeManager.theme.padding)
        .padding(.top, themeManager.theme.padding)
        .padding(.bottom, themeManager.theme.padding)
    }
}

// MARK: -

public struct FaustVBargraph: View {
    public let label: String
    public let address: String
    public let min: Double
    public let max: Double
    @Binding var value: Double
    @EnvironmentObject var themeManager: FaustThemeManager

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        VStack(alignment: .center) {
            Text(label).frame(alignment: .center)

            VStack(alignment: .center, spacing: 0) {
                GeometryReader { geometry in
                    let percent = CGFloat((value - min) / (max - min))
                    ZStack(alignment: .bottom) {
                        Rectangle().fill(Color.gray.opacity(0.2))
                        Rectangle().fill(Color.green)
                            .frame(height: geometry.size.height * percent)
                    }
                    .cornerRadius(themeManager.theme.cornerRadius)
                }
                .frame(width: 12.5)
                .frame(height: themeManager.theme.sliderSize)
            }

            HStack {
                Text(String(format: "%.1f", value))
                    .frame(height: themeManager.theme.labelSize)
                    .frame(minWidth: themeManager.theme.labelSize * 2, maxWidth: themeManager.theme.labelSize * 3)
                    .background(themeManager.theme.numboxBackgroundColor)
                    .foregroundColor(themeManager.theme.numboxTextColor)
                    .cornerRadius(themeManager.theme.cornerRadius)
            }
            .padding(.leading, themeManager.theme.padding)
            .padding(.trailing, themeManager.theme.padding)
        }
        .frame(width: themeManager.theme.labelSize * 2.5)
        .padding(.leading, themeManager.theme.padding)
        .padding(.trailing, themeManager.theme.padding)
        .padding(.top, themeManager.theme.padding)
        .padding(.bottom, themeManager.theme.padding)
    }
}

// MARK: -

public struct FaustHBargraph: View {
    public let label: String
    public let address: String
    public let min: Double
    public let max: Double
    @Binding var value: Double
    @EnvironmentObject var themeManager: FaustThemeManager

    public var body: some View { render }

    @ViewBuilder
    private var render_label: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .frame(height: themeManager.theme.labelSize)

            Text(String(format: "%.1f", value))
                .frame(height: themeManager.theme.labelSize)
                .frame(minWidth: themeManager.theme.labelSize * 2, maxWidth: themeManager.theme.labelSize * 3)
                .background(themeManager.theme.numboxBackgroundColor)
                .foregroundColor(themeManager.theme.numboxTextColor)
                .cornerRadius(themeManager.theme.cornerRadius)

            Spacer().frame(height: themeManager.theme.labelSize * 1)
        }
    }

    @ViewBuilder
    private var render: some View {
        HStack(alignment: .top) {
            render_label

            VStack(alignment: .center, spacing: 0) {
                Spacer().frame(height: themeManager.theme.labelSize)
                GeometryReader { geometry in
                    let percent = CGFloat((value - min) / (max - min))
                    ZStack(alignment: .leading) {
                        Rectangle().fill(Color.gray.opacity(0.2))
                        Rectangle().fill(Color.green)
                            .frame(width: geometry.size.width * percent)
                    }
                    .cornerRadius(themeManager.theme.cornerRadius)
                }
                .frame(height: themeManager.theme.labelSize * 0.5)
            }
            .frame(height: themeManager.theme.labelSize * 2)
            .frame(width: themeManager.theme.sliderSize)
        }

        .frame(height: themeManager.theme.labelSize * 3)
        .frame(width: themeManager.theme.labelSize * 2 + themeManager.theme.sliderSize)
        .padding(.leading, themeManager.theme.padding)
        .padding(.trailing, themeManager.theme.padding)
    }
}

// MARK: -

struct FaustNSwitch: View {
    public let label: String
    public let address: String
    let range: ClosedRange<Double>
    let step: Double
    @Binding var value: Double
    @EnvironmentObject var themeManager: FaustThemeManager

    @State private var text: String

    public init(label: String, address: String, range: ClosedRange<Double>, step: Double, value: Binding<Double>) {
        self.label = label
        self.address = address
        self.range = range
        self.step = step
        _value = value

        _text = State(initialValue: String(value.wrappedValue))
    }

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(label)
                    .multilineTextAlignment(.center)
                    .frame(height: themeManager.theme.labelSize)

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
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: themeManager.theme.labelSize)
                    .frame(minWidth: themeManager.theme.labelSize * 2, maxWidth: themeManager.theme.labelSize * 3)

                Spacer()
                    .frame(height: themeManager.theme.labelSize * 1)
            }
        }
        .frame(height: themeManager.theme.labelSize * 3)
        .frame(minWidth: themeManager.theme.labelSize * 2, maxWidth: themeManager.theme.labelSize * 3)
        .padding(.leading, themeManager.theme.padding)
        .padding(.trailing, themeManager.theme.padding)
    }
}

// MARK: -

struct FaustHSlider: View {
    public let label: String
    public let address: String
    let range: ClosedRange<Double>
    let step: Double
    @Binding var value: Double
    @EnvironmentObject var themeManager: FaustThemeManager

    @State private var isDragging = false
    @GestureState private var dragOffset: CGSize = .zero

    public var body: some View { render }

    @ViewBuilder
    private var render_label: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .frame(height: themeManager.theme.labelSize)

            Text(String(format: "%.1f", value))
                .frame(height: themeManager.theme.labelSize)
                .frame(minWidth: themeManager.theme.labelSize * 2, maxWidth: themeManager.theme.labelSize * 3)
                .background(themeManager.theme.numboxBackgroundColor)
                .foregroundColor(themeManager.theme.numboxTextColor)
                .cornerRadius(themeManager.theme.cornerRadius)

            Spacer()
                .frame(height: themeManager.theme.labelSize)
        }
    }

    @ViewBuilder
    private var render: some View {
        HStack(alignment: .center) {
            render_label

            VStack(spacing: 0) {
                if value < range.lowerBound || value > range.upperBound {
                    Text("Value out of range: \(value) \(range.lowerBound) \(range.upperBound)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .cornerRadius(0)
                } else {
                    GeometryReader { geo in
                        let height = geo.size.height * 0.75
                        let width = geo.size.width
                        let trackHeight = geo.size.height * 0.25
                        let handleWidth = trackHeight * 1.5
                        // let totalSteps = (range.upperBound - range.lowerBound) / step
                        let normalized = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
                        let handleX = normalized * (width - handleWidth)

                        ZStack(alignment: .leading) {
                            // Track
                            RoundedRectangle(cornerRadius: themeManager.theme.cornerRadius)
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: trackHeight)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, (height - trackHeight) / 2)

                            // Handle
                            RoundedRectangle(cornerRadius: themeManager.theme.cornerRadius)
                                .fill(isDragging ? Color.accentColor : Color.primary.opacity(0.2))
                                .overlay(
                                    RoundedRectangle(cornerRadius: themeManager.theme.cornerRadius)
                                        .stroke(Color.accentColor, lineWidth: 1.5)
                                )
                                .frame(width: handleWidth, height: height)
                                .position(x: handleX + handleWidth / 2, y: height * 0.67)
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
                    .frame(height: themeManager.theme.labelSize * 2)
                    .frame(width: themeManager.theme.sliderSize)
                }
            }
        }
        .frame(height: themeManager.theme.labelSize * 3)
        .frame(width: themeManager.theme.labelSize * 2 + themeManager.theme.sliderSize)
        .padding(.leading, themeManager.theme.padding)
        .padding(.trailing, themeManager.theme.padding)
    }
}

// MARK: -

struct FaustVSlider: View {
    public let label: String
    public let address: String
    let range: ClosedRange<Double>
    let step: Double
    @Binding var value: Double
    @EnvironmentObject var themeManager: FaustThemeManager

    @State private var isDragging = false
    @GestureState private var dragOffset: CGSize = .zero

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        HStack(spacing: 0) {
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

                        let width = geo.size.width * 0.75
                        let height = geo.size.height
                        let trackWidth = geo.size.width * 0.25
                        let handleHeight = trackWidth * 1.5 // width * 0.4
                        // let totalSteps = (range.upperBound - range.lowerBound) / step
                        let normalized = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
                        let handleY = (1.0 - normalized) * (height - handleHeight)

                        ZStack(alignment: .top) {
                            // Track
                            RoundedRectangle(cornerRadius: themeManager.theme.cornerRadius)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: trackWidth)
                                .frame(maxHeight: .infinity)
                                .padding(.horizontal, (width - trackWidth) / 2)

                            // Handle
                            RoundedRectangle(cornerRadius: themeManager.theme.cornerRadius)
                                .fill(isDragging ? Color.accentColor : Color.primary.opacity(0.2))
                                .overlay(
                                    RoundedRectangle(cornerRadius: themeManager.theme.cornerRadius)
                                        .stroke(Color.accentColor, lineWidth: 2)
                                )
                                .frame(width: width, height: handleHeight)
                                .position(x: width * 0.67, y: handleY + handleHeight / 2)
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
                    .frame(width: themeManager.theme.labelSize * 2, height: themeManager.theme.sliderSize)

                    HStack {
                        Text(String(format: "%.1f", value))
                            .frame(height: themeManager.theme.labelSize)
                            .frame(minWidth: themeManager.theme.labelSize * 2, maxWidth: themeManager.theme.labelSize * 4)
                            .background(themeManager.theme.numboxBackgroundColor)
                            .foregroundColor(themeManager.theme.numboxTextColor)
                            .cornerRadius(themeManager.theme.cornerRadius)
                    }
                    .padding(.leading, themeManager.theme.padding)
                    .padding(.trailing, themeManager.theme.padding)
                }
            }
        }
        .padding(themeManager.theme.padding)
        .frame(width: themeManager.theme.labelSize * 3)
//        .border(.black, width:1)
    }
}

// MARK: -

struct FaustKnob: View {
    public let label: String
    public let address: String
    public let range: ClosedRange<Double>
    public let step: Double
    @Binding var value: Double
    @EnvironmentObject var themeManager: FaustThemeManager

    private let thickness: CGFloat = 12.0
    private let totalAngle: Angle = .degrees(300)
    private let startAngle: Angle = .degrees(120) // leaves 60° gap at bottom

    public var body: some View { render }

    @ViewBuilder
    private var render: some View {
        HStack(spacing: 0) {
            VStack(alignment: .center) {
                Text(label)
                    .multilineTextAlignment(.center)

                GeometryReader { geometry in

                    let size = min(geometry.size.width, geometry.size.height)
                    let center = CGPoint(x: size / 2, y: size / 2)
                    let radius = (size - thickness) / 2
                    let offset = Angle(degrees:1)
                    
                    let normalized = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
                    
                    let angle = (totalAngle.radians - offset.radians) * Double(normalized)
                    let endAngle = startAngle + offset + Angle(radians: angle)   // offset added
                    
                    let height = geometry.size.height

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

                                let location = gesture.location.y
                                let clamped = min(max(location - 0 / 2, 0), height - 0)
                                let percent = 1.0 - (clamped / (height - 0))
                                
                                let scaled = (Double(percent) * (range.upperBound - range.lowerBound))  + range.lowerBound

                                value = min(max(scaled, range.lowerBound), range.upperBound)
                            }
                    )
                }
                .aspectRatio(1, contentMode: .fit)
                
                HStack {
                    Text(String(format: "%.1f", value))
                        .frame(height: themeManager.theme.labelSize)
                        .frame(minWidth: themeManager.theme.labelSize * 2, maxWidth: themeManager.theme.labelSize * 4)
                        .background(themeManager.theme.numboxBackgroundColor)
                        .foregroundColor(themeManager.theme.numboxTextColor)
                        .cornerRadius(themeManager.theme.cornerRadius)
                }
                .padding(.leading, themeManager.theme.padding)
                .padding(.trailing, themeManager.theme.padding)
            }
        }
        .padding(themeManager.theme.padding)
        .frame(width: themeManager.theme.labelSize * 3)
    }
}

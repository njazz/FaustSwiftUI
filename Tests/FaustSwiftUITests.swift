// FaustSwiftUITests.swift
// Basic example for testing FaustUIWrapper with SwiftUI preview

import SwiftUI
import XCTest

@testable import FaustSwiftUI

final class FaustSwiftUITests: XCTestCase {
    func testExampleUI() {
        let dummyJSON: [FaustUI] = [
            FaustUI(
                type: .vgroup,
                label: "Test Group",
                address: nil,
                items: [
                    FaustUI(type: .vslider, label: "Volume", address: "/volume", items: nil, initValue: 0.5, min: 0.0, max: 1.0, step: 0.01),
                    FaustUI(type: .checkbox, label: "Bypass", address: "/bypass", items: nil, initValue: 0.0, min: nil, max: nil, step: nil),
                    FaustUI(type: .vbargraph, label: "Output", address: "/output", items: nil, initValue: nil, min: nil, max: nil, step: nil)
                ],
                initValue: nil, min: nil, max: nil, step: nil
            )
        ]

        let viewModel = FaustUIViewModel()
        viewModel.setValue(0.5, for: "/volume")
        viewModel.setValue(1.0, for: "/output")

        let view = FaustUIView(ui: dummyJSON, viewModel: viewModel)

        XCTAssertNotNil(view)
    }
}


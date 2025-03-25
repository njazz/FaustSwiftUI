// FaustUIViewModel.swift
// ViewModel to store and update Faust UI values

import Foundation
import Combine

public protocol FaustUIValueBinding: ObservableObject {
    func getValue(for address: String, default defaultValue: Double) -> Double
    func setValue(_ value: Double, for address: String)
}

public class FaustUIViewModel: FaustUIValueBinding {
    @Published public var values: [String: Double] = [:]

    public init() {}

    public func setValue(_ value: Double, for address: String) {
        values[address] = value
    }

    public func getValue(for address: String, default defaultValue: Double = 0.0) -> Double {
        values[address] ?? defaultValue
    }
}

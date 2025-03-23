// FaustUI.swift
// Data model representing JSON UI nodes from Faust

import Foundation

public enum FaustUIType: String, Codable {
    case vslider, hslider, nentry
    case checkbox, button
    case vgroup, hgroup, tgroup
    case hbargraph, vbargraph
}

public struct FaustUI: Codable, Identifiable {
    public let id: UUID = UUID()

    public let type: FaustUIType
    public let label: String
    public let varname: String?
    public let shortname: String?
    public let address: String?
    public let items: [FaustUI]?

    public let initValue: Double?
    public let min: Double?
    public let max: Double?
    public let step: Double?

    public init(
        type: FaustUIType,
        label: String,
        varname: String? = nil,
        shortname: String? = nil,
        address: String? = nil,
        items: [FaustUI]? = nil,
        initValue: Double? = nil,
        min: Double? = nil,
        max: Double? = nil,
        step: Double? = nil
    ) {
        self.type = type
        self.label = label
        self.varname = varname
        self.shortname = shortname
        self.address = address
        self.items = items
        self.initValue = initValue
        self.min = min
        self.max = max
        self.step = step
    }

    enum CodingKeys: String, CodingKey {
        case type, label, varname, shortname, address, items, initValue, min, max, step
    }
}

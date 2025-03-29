// FaustUI.swift
// Data model representing JSON UI nodes from Faust

import Foundation

public enum FaustUIStyle: String, Codable {
    case knob, led, numerical
}

public enum FaustUIDerivedType {
    case hdbbargraph, vdbbargraph, knob, menu, radio, led, numerical
}

public enum FaustUIScale : String, Codable{
    case linear, log, exp
}

public enum FaustUIType: String, Codable {
    case vslider, hslider, nentry
    case checkbox, button
    case vgroup, hgroup, tgroup
    case hbargraph, vbargraph
}

public struct FaustUIMeta: Codable {
    public let style: FaustUIStyle?
    public let unit: String?
    public let scale: FaustUIScale?
    public let tooltip: String?
    public let hidden: Bool?    
}

public struct FaustUIJSON: Codable {
    public let ui: [FaustUI]?
}

public struct FaustUI: Codable, Identifiable {
    public let id: UUID = UUID()

    public let type: FaustUIType
    public let label: String
    public let varname: String?
    public let shortname: String?
    public let address: String?
    public let meta: [FaustUIMeta]?
    public let items: [FaustUI]?

    public let initValue: Double?
    public let min: Double?
    public let max: Double?
    public let step: Double?

    // private: derived from JSON
    private var derivedType: FaustUIDerivedType? = nil
    private var units: String? = nil
    private var tooltip: String? = nil
    private var scale: FaustUIScale = .linear
    private var hidden: Bool = true
    
    public init(
        type: FaustUIType,
        label: String,
        varname: String? = nil,
        shortname: String? = nil,
        address: String? = nil,
        meta: [FaustUIMeta]? = nil,
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
        self.meta = meta
        self.items = items
        self.initValue = initValue
        self.min = min
        self.max = max
        self.step = step
        
        // process derived values here:
    }

    enum CodingKeys: String, CodingKey {
        case type, label, varname, shortname, address, meta, items, initValue, min, max, step
    }
}

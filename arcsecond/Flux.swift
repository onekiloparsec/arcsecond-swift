//
//  Flux.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 11/09/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Flux {
    public let name: String
    public let value: Double
    public let bibcode: String

    private(set) public var errorMax: Double? = nil
    private(set) public var errorMin: Double? = nil
    
    init(json: [String: Any]?) throws {
        guard let _name = json?["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        guard let _value = json?["value"] as? Double else {
            throw SerializationError.missing("value")
        }

        guard let _bibcode = json?["bibcode"] as? String else {
            throw SerializationError.missing("bibcode")
        }

        self.name = _name
        self.value = _value
        self.bibcode = _bibcode
        
        if let _errorMax = json?["error_max"] as? Double {
            self.errorMax = _errorMax
        }

        if let _errorMin = json?["error_min"] as? Double {
            self.errorMin = _errorMin
        }
    }
}


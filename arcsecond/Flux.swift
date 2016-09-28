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
    public let errorMax: Double
    public let errorMin: Double
    public let bibcode: String
    
    init?(json: [String: Any]?) throws {
        guard let _name = json?["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        guard let _value = json?["value"] as? Double else {
            throw SerializationError.missing("value")
        }

        guard let _errorMin = json?["error_max"] as? Double else {
            throw SerializationError.missing("error_max")
        }

        guard let _errorMax = json?["error_min"] as? Double else {
            throw SerializationError.missing("error_min")
        }

        guard let _bibcode = json?["bibcode"] as? String else {
            throw SerializationError.missing("bibcode")
        }

        self.name = _name
        self.value = _value
        self.errorMax = _errorMax
        self.errorMin = _errorMin
        self.bibcode = _bibcode
    }
}


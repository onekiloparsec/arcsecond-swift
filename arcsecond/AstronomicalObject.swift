//
//  Object.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct AstronomicalObject {
    public let name: String
    public let coordinates: Coordinates
    public let aliases: [Alias]
    public let fluxes: [Flux]
    
    init(json: [String: Any]?) throws {
        guard let _name = json?["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        guard let _aliasesJSON = json?["aliases"] as? [[String: Any]] else {
            throw SerializationError.missing("aliases")
        }
        
        var _aliases: [Alias] = []
        for _alias in _aliasesJSON {
            _aliases.append(try Alias(json: _alias))
        }

        guard let _fluxesJSON = json?["fluxes"] as? [[String: Any]] else {
            throw SerializationError.missing("fluxes")
        }
        
        var _fluxes: [Flux] = []
        for _flux in _fluxesJSON {
            _fluxes.append(try Flux(json: _flux))
        }

        self.name = _name
        self.aliases = _aliases
        self.fluxes = _fluxes
        self.coordinates = try Coordinates(json: json?["coordinates"] as? [String: Any])
    }
}


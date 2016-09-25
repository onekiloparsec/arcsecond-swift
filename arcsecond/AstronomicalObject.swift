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
//    public let coordinates: Coordinates
//    public let aliases: [Alias]
//    public let fluxes: [Flux]
    
    init?(json: [String: Any]?) throws {
        guard let aname = json?["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        self.name = aname
     
//        guard case self.coordinates = Coordinates(json: json?["coordinates"] as? [String: Any]) else {
//            throw SerializationError.missing("coordinates")
//        }        
    }
}


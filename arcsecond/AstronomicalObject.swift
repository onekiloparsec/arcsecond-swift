//
//  Object.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import RealmSwift

func AstronomicalObjectValidator(json: [String: Any]) throws -> [String: Any] {
    guard json["name"] as? String != nil else {
        throw SerializationError.missing("name")
    }
    
    guard json["aliases"] as? [[String: Any]] != nil else {
        throw SerializationError.missing("aliases")
    }
    
    return json
}

public class AstronomicalObject: Object {    
    dynamic var name: String = ""
    dynamic var coordinates: Coordinates?
    public let aliases = List<Alias>()
    public let fluxes = List<Flux>()
    
    public override class func primaryKey() -> String? {
        return "name"
    }
}


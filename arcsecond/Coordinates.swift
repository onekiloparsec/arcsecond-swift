//
//  Coordinates.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 11/09/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import RealmSwift

func CoordinatesValidator(json: [String: AnyObject]) throws -> [String: AnyObject] {
    guard json["longitude"] as? Double != nil else {
        throw SerializationError.missing("longitude")
    }
    
    guard json["latitude"] as? Double != nil else {
        throw SerializationError.missing("latitude")
    }
    
// 'height' property may be null.
//    guard json["height"] as? String != nil else {
//        throw SerializationError.missing("height")
//    }
    
    return json
}

public class Coordinates: Object {
    @objc public dynamic var longitude: Double = 0.0
    @objc public dynamic var latitude: Double = 0.0
    public let height = RealmOptional<Double>()
}



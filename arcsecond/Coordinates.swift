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
    guard json["longitude"] as? Float != nil else {
        throw SerializationError.missing("longitude")
    }
    
    guard json["latitude"] as? Float != nil else {
        throw SerializationError.missing("latitude")
    }
    
// 'height' property may be null.
//    guard json["height"] as? String != nil else {
//        throw SerializationError.missing("height")
//    }
    
    return json
}

public class Coordinates: Object {
    public dynamic var longitude: Float = 0.0
    public dynamic var latitude: Float = 0.0
    public let height = RealmOptional<Float>()
}



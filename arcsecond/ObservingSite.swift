//
//  ObservingSite.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 21/01/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

func ObservingSiteValidator(json: [String: Any]) throws -> [String: Any] {
    guard json["uuid"] as? String != nil else {
        throw SerializationError.missing("uuid")
    }
    
    guard json["name"] as? [[String: Any]] != nil else {
        throw SerializationError.missing("name")
    }
    
    return json
}

public class ObservingSite: Object {
    public dynamic var uuid: String = ""
    public dynamic var name: String = ""
//    dynamic var coordinates: Coordinates?
    
    override public static func primaryKey() -> String? {
        return "uuid"
    }    
}

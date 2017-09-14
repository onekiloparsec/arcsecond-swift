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
    
    guard json["name"] as? String != nil else {
        throw SerializationError.missing("name")
    }
    
    guard json["IAUCode"] as? String != nil else {
        throw SerializationError.missing("IAUCode")
    }

    return json
}

public class ObservingSite: Object {
    public dynamic var uuid: String = ""
    public dynamic var name: String = ""
    public dynamic var IAUCode: String = ""
    public dynamic var coordinates: Coordinates?
    
    override public static func primaryKey() -> String? {
        return "uuid"
    }    
}

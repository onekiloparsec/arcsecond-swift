//
//  Alias.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import RealmSwift

public class Alias: Object {
    @objc public dynamic var name: String = ""
    @objc public dynamic var catalogueURL: String = ""

    public override class func primaryKey() -> String? {
        return "name"
    }
}


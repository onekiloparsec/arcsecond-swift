//
//  Object.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public class AstronomicalObject {
    public let name: String
    public let aliases: [Alias]
    
    init(json: [String: AnyObject]) {
        self.name = json["name"] as! String
        let aliases = json["aliases"] as? [[String: String]]
        self.aliases = aliases.map({ (json) -> Alias in
            return Alias(json: json, parentObject: self)
        })
    }
}
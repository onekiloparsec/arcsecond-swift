//
//  Alias.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public class Alias {
    public let name: String
    public let catalogueURL: NSURL?
    public weak private(set) var parentObject: AstronomicalObject!
    
    init(json: [String : String], parentObject: AstronomicalObject) {
        self.name = json["name"]!
        self.catalogueURL = (json["catalogue_url"] != nil) ? NSURL(string: json["catalogue_url"]!) : nil
        self.parentObject = parentObject
    }
}
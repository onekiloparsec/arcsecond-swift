//
//  Alias.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Alias {
    public let name: String
    public let catalogueURL: String

    init?(json: [String: Any]?) throws {
        guard let _name = json?["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        guard let _url = json?["catalog_url"] as? String else {
            throw SerializationError.missing("catalog_url")
        }
        
        self.name = _name
        self.catalogueURL = _url
    }
}


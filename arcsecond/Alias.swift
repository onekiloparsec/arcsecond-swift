//
//  Alias.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import Argo
import Curry

public struct Alias {
    public let name: String
    public let catalogueURL: String
}

extension Alias: Decodable {
    public static func decode(json: JSON) -> Decoded<Alias> {
        return curry(Alias.init)
            <^> json <| "name"
            <*> json <| "catalogue_url"
    }
}


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
import Runes

public struct Alias {
    public let name: String
    public let catalogueURL: String?
}

extension Alias: Decodable {
    public static func decode(j: JSON) -> Decoded<Alias> {
        return curry(Alias.init)
            <^> j <| "name"
            <*> j <|? "catalogue_url"
    }
}


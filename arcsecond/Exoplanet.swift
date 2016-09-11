//
//  Exoplanet.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import Argo
import Curry

public struct Exoplanet {
    public let name: String
}

extension Exoplanet: Decodable {
    public static func decode(json: JSON) -> Decoded<Exoplanet> {
        return curry(Exoplanet.init)
            <^> json <| "name"
    }
}



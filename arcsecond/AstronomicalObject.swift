//
//  Object.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import Argo
import Curry

public struct AstronomicalObject {
    public let name: String
    public let coordinates: Coordinates
    public let aliases: [Alias]
    public let fluxes: [Flux]
}

extension AstronomicalObject: Decodable {
    public static func decode(json: JSON) -> Decoded<AstronomicalObject> {
        return curry(AstronomicalObject.init)
            <^> json <| "name"
            <*> json <| "coordinates"
            <*> json <|| "aliases"
            <*> json <|| "fluxes"
    }
}



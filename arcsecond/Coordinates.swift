//
//  Coordinates.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 11/09/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import Argo
import Curry

public struct Coordinates {
    public let system: String
    public let rightAscension: Double
    public let rightAscensionUnits: String
    public let declination: Double
    public let declinationUnits: String
    public let epoch: Double
    public let equinox: Double
}

extension Coordinates: Decodable {
    public static func decode(json: JSON) -> Decoded<Coordinates> {
        return curry(Coordinates.init)
            <^> json <| "system"
            <*> json <| "right_ascension"
            <*> json <| "right_ascension_units"
            <*> json <| "declination"
            <*> json <| "declination_units"
            <*> json <| "epoch"
            <*> json <| "equinox"
    }
}


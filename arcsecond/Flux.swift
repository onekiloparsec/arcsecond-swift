//
//  Flux.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 11/09/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import Argo
import Curry

public struct Flux {
    public let name: String
    public let value: Double
    public let errorMax: Double
    public let errorMin: Double
    public let bibcode: String
}

extension Flux: Decodable {
    public static func decode(json: JSON) -> Decoded<Flux> {
        return curry(Flux.init)
            <^> json <| "name"
            <*> json <| "value"
            <*> json <| "error_max"
            <*> json <| "error_min"
            <*> json <| "bibcode"
    }
}


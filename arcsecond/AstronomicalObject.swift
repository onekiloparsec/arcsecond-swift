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
}

extension AstronomicalObject: Decodable {
    public static func decode(json: JSON) -> Decoded<AstronomicalObject> {
        return curry(AstronomicalObject.init)
            <^> json <| "name"
    }
}



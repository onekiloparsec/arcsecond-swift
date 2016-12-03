//
//  arcsecond.swift
//  arcsecond
//
//  Created by Cédric Foellmi on 15/08/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

import Foundation
import PromiseKit
import RealmSwift

// Auth

public func login(username: String, password: String) -> Promise<[String: Any]> {
    return ArcsecondService.sharedDefault.login(username: username, password: password)
}

// Singles

public func object(_ name: String) -> Promise<AstronomicalObject> {
    return ArcsecondService.sharedDefault.object(name)
}

public func exoplanet(_ name: String) -> Promise<Exoplanet> {
    return ArcsecondService.sharedDefault.exoplanet(name)
}

public func save(_ obj: Object) throws {
    try ArcsecondService.sharedDefault.save(obj)
}


// Collections

public func objects() -> Promise<[AstronomicalObject]> {
    return ArcsecondService.sharedDefault.objects()
}

public func exoplanets() -> Results<Exoplanet> {
    return ArcsecondService.sharedDefault.exoplanets()
}


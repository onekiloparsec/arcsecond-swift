//
//  arcsecond.swift
//  arcsecond
//
//  Created by Cédric Foellmi on 15/08/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

import Foundation
import RealmSwift
import Siesta

// Auth

public func login(username: String, password: String) -> Siesta.Request {
    return ArcsecondService.sharedDefault.login(username: username, password: password)
}

public func logout() -> Siesta.Request {
    return ArcsecondService.sharedDefault.logout()
}

// Singles

public func objectResource(named name: String, closure: @escaping AstronomicalObjectResourceClosure) -> Siesta.Resource {
    return ArcsecondService.sharedDefault.objectResource(named: name, closure: closure)
}


// Collections

//public func objects() -> Results<[AstronomicalObject]> {
//    return ArcsecondService.sharedDefault.objects()
//}
//
//public func exoplanets() -> Results<Exoplanet> {
//    return ArcsecondService.sharedDefault.exoplanets()
//}


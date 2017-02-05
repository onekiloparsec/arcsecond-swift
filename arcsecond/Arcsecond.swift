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

public func observeObjectResource(withName name: String, observer: AnyObject, closure: @escaping Siesta.ResourceObserverClosure) {
    return ArcsecondService.sharedDefault.observeObjectResource(withName: name, observer: observer, closure: closure)
}

public func observeExoplanetResource(withName name: String, observer: AnyObject, closure: @escaping Siesta.ResourceObserverClosure) {
    return ArcsecondService.sharedDefault.observeExoplanetResource(withName: name, observer: observer, closure: closure)
}

public func observeObservingSiteResource(withUUID uuid: String, observer: AnyObject, closure: @escaping Siesta.ResourceObserverClosure) {
    return ArcsecondService.sharedDefault.observeObservingSiteResource(withUUID: uuid, observer: observer, closure: closure)
}

// Collections

public func observeObservingSitesResource(observer: AnyObject, closure: @escaping Siesta.ResourceObserverClosure) {
    return ArcsecondService.sharedDefault.observeObservingSitesResource(observer: observer, closure: closure)
}


//public func objects() -> Results<[AstronomicalObject]> {
//    return ArcsecondService.sharedDefault.objects()
//}
//
//public func exoplanets() -> Results<Exoplanet> {
//    return ArcsecondService.sharedDefault.exoplanets()
//}


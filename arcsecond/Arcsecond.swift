//
//  arcsecond.swift
//  arcsecond
//
//  Created by Cédric Foellmi on 15/08/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

import Foundation
import Siesta
import Realm
import RealmSwift

public var defaultAPISource: APISource = .production

// Auth

public func login(_ source: APISource = defaultAPISource, username: String, password: String) -> Siesta.Request {
    return Arcsecond.service(source).login(username: username, password: password)
}

public func logout(_ source: APISource = defaultAPISource) -> Siesta.Request {
    return Arcsecond.service(source).logout()
}

// Singles

public func observeObjectResource(_ source: APISource = defaultAPISource,
                                  withName name: String,
                                  observer: AnyObject,
                                  closure: @escaping Siesta.ResourceObserverClosure)
{
    return Arcsecond.service(source).observeObjectResource(withName: name, observer: observer, closure: closure)
}

public func observeExoplanetResource(_ source: APISource = defaultAPISource,
                                     withName name: String,
                                     observer: AnyObject,
                                     closure: @escaping Siesta.ResourceObserverClosure)
{
    return Arcsecond.service(source).observeExoplanetResource(withName: name, observer: observer, closure: closure)
}

public func observeObservingSiteResource(_ source: APISource = defaultAPISource,
                                         withUUID uuid: String,
                                         observer: AnyObject,
                                         closure: @escaping Siesta.ResourceObserverClosure)
{
    return Arcsecond.service(source).observeObservingSiteResource(withUUID: uuid, observer: observer, closure: closure)
}

// Collections

public func observeObservingSitesResource(_ source: APISource = defaultAPISource,
                                          observer: AnyObject,
                                          closure: @escaping Siesta.ResourceObserverClosure)
{
    return Arcsecond.service(source).observeObservingSitesResource(observer: observer, closure: closure)
}

// Storage

public func save(_ source: APISource = defaultAPISource, object: Object) {
    try! Arcsecond.service(source).save(object)
}

public func save(_ source: APISource = defaultAPISource, objects: [Object]) {
    objects.forEach { try! Arcsecond.service(source).save($0) }
}

// Private

private func service(_ source: APISource = defaultAPISource) -> ArcsecondService {
    switch source {
    case .localhost: return ArcsecondService.sharedLocalDefault
    case .staging: return ArcsecondService.sharedStagingDefault
    case .production: return ArcsecondService.sharedDefault
    }
}


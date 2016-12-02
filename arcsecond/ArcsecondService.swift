//
//  ArcsecondService.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 11/09/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import Siesta
import PromiseKit
import RealmSwift
import Realm

public class ArcsecondService : Service {
    public let APIVersion: String
    public static let sharedDefault: ArcsecondService = { return ArcsecondService() }()
    
    private let realmConfiguration: Realm.Configuration
    
    public init(withAPIVersion version: String = "1") {
        self.APIVersion = version
        
        let filename = "arcsecond.\(version).realm"
        let fileurl = URL(fileURLWithPath: RLMRealmPathForFile(filename), isDirectory: false)
        self.realmConfiguration = Realm.Configuration(fileURL: fileurl)
        
        super.init(baseURL: "http://api.arcsecond.io")
        
        self.configure {
            $0.expirationTime = 86400.0  // default is 30 seconds 
        }
        
        self.configureTransformer("/\(self.APIVersion)/objects/*") {
            AstronomicalObject(value: try AstronomicalObjectValidator(json: $0.content))
        }
        
        self.configureTransformer("/\(self.APIVersion)/exoplanets/*") {
            Exoplanet(value: $0.content)
        }
    }
    
    public func save(_ obj: Object) throws {
        guard obj.realm == nil else {
            // This doesn't mean the object is already recorded! Hence, this won't return and will cresh on realm.add()
            // nonetheless with message: "Can't create object with existing primary key value 'BAT99 129'" ???
            return
        }
        let realm = try! Realm(configuration: self.realmConfiguration)
        try realm.write {
            realm.add(obj, update: false)
        }
    }

    // Collections
    
    public func localObjects() -> Results<AstronomicalObject> {
        let realm = try! Realm(configuration: self.realmConfiguration)
        return realm.objects(AstronomicalObject.self)
    }

    public func objects() -> Promise<[AstronomicalObject]> {
        return self.collectionPromise("objects") as Promise<[AstronomicalObject]>
    }

    public func exoplanets() -> Results<Exoplanet> {
        let realm = try! Realm(configuration: self.realmConfiguration)
        return realm.objects(Exoplanet.self)
    }
    
    private func collectionPromise<T: Object>(_ path: String) -> Promise<[T]> {
        return Promise { fulfill, reject in
            let resource = self.resource("/\(self.APIVersion)/\(path)/")
            resource.addObserver(owner: self) { resource, event in
                if case .newData = event {
                    let objs = resource.latestData!.content as! [T]
                    objs.forEach { try! self.save($0) }
                    fulfill(objs)
                }
                else if case .error = event {
                    reject(resource.latestError!)
                }
            }
            resource.loadIfNeeded()
        }
    }

    // Singles
        
    public func object(_ name: String) -> Promise<AstronomicalObject> {
        return self.namedObjectPromise(name, path: "objects") as Promise<AstronomicalObject>
    }
    
    public func exoplanet(_ name: String) -> Promise<Exoplanet> {
        return self.namedObjectPromise(name, path: "exoplanets") as Promise<Exoplanet>
    }
    
    private func namedObjectPromise<T: Object>(_ name: String, path: String) -> Promise<T> {
        return Promise { fulfill, reject in
            let resource = self.resource("/\(self.APIVersion)/\(path)/\(name)")
            resource.addObserver(owner: self) { resource, event in
                if case .newData = event {
                    let obj = resource.latestData!.content as! T
                    if (obj.realm != nil) { try! self.save(obj) }
                    fulfill(obj)
                }
                else if case .error = event {
                    reject(resource.latestError!)
                }
            }
            resource.loadIfNeeded()
        }
    }
}

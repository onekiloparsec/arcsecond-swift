//
//  ArcsecondService.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 11/09/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import Siesta
import RealmSwift
import Realm

public enum ArcsecondResourceEvent {
    case remote(Siesta.ResourceEvent)
    case local(Arcsecond.ArcsecondResourceEvent.StorageEvent)
    
    public enum StorageEvent: String {
        case simpleQuery
    }
}

public typealias AstronomicalObjectResourceClosure = (AstronomicalObject?, ArcsecondResourceEvent) -> ()

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
    
    // Auth
    
    public func login(username: String, password: String) -> Siesta.Request {
        return self.resource("/auth/login/").request(.post, json: ["username": username, "password": password])
    }

    public func logout() -> Siesta.Request {
        return self.resource("/auth/logout/").request(.post)
    }
        
    // Singles

    internal func save(_ obj: Object) throws {
        let realm = try! Realm(configuration: self.realmConfiguration)
        try realm.write {
            realm.add(obj, update: true)
        }
    }

    internal func get<T: Object>(named name: String, ofType: T.Type) -> T? {
        let realm = try! Realm(configuration: self.realmConfiguration)
        return realm.object(ofType: T.self, forPrimaryKey: name)
    }

    public func objectResource(named name: String, closure: @escaping AstronomicalObjectResourceClosure) -> Siesta.Resource {
        let path = "objects"
        let serviceResource = self.resource("/\(self.APIVersion)/\(path)/\(name)")
        
        if let obj = self.get(named: name, ofType: AstronomicalObject.self) {
            closure(obj, .local(.simpleQuery))
        }
        else {
            serviceResource.addObserver(owner: self) {
                [weak self] resource, event in
                var obj: AstronomicalObject? = nil
                
                switch event {
                case .newData(.network):
                    obj = resource.latestData!.content as? AstronomicalObject
                    try! self?.save(obj!)
                default:
                    break
                }
                
                closure(obj, .remote(event))
            }
            serviceResource.loadIfNeeded()
        }

        return serviceResource
    }
    
    // Collections
    
    public func localObjects() -> Results<AstronomicalObject> {
        let realm = try! Realm(configuration: self.realmConfiguration)
        return realm.objects(AstronomicalObject.self)
    }
}

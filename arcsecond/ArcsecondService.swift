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

public enum APISource: String {
    case localhost = "http://api.lvh.me:8000"
    case staging = "http://arcsecond-staging.herokuapp.com/api"
    case production = "http://api.arcsecond.io"
    
    func key() -> String {
        switch self {
        case .localhost: return "localhost"
        case .staging: return "staging"
        case.production: return "production"
        }
    }
}

public class ArcsecondService: Service {
    public static let sharedDefault: ArcsecondService = { return ArcsecondService() }()
    public static let sharedStagingDefault: ArcsecondService = { return ArcsecondService(usingSource: .staging) }()
    public static let sharedLocalDefault: ArcsecondService = { return ArcsecondService(usingSource: .localhost) }()
    
    private let realmConfiguration: Realm.Configuration
    
    public init(usingSource source: APISource = .production) {
        
        let filename = "arcsecond.\(source.key()).realm"
        let fileurl = URL(fileURLWithPath: RLMRealmPathForFile(filename), isDirectory: false)
        self.realmConfiguration = Realm.Configuration(fileURL: fileurl)
        
        super.init(baseURL: source.rawValue)
        
        self.configure {
            $0.expirationTime = 86400.0  // default is 30 seconds 
        }
        
        self.configureTransformer("/objects/*") {
            AstronomicalObject(value: try AstronomicalObjectValidator(json: $0.content))
        }
        
        self.configureTransformer("/exoplanets/*") {
            Exoplanet(value: $0.content)
        }

        self.configureTransformer("/observingsites/*") {
            ObservingSite(value: $0.content)
        }
        
        self.configureTransformer("/observingsites/") {
            ($0.content as [AnyObject]).map { ObservingSite(value: $0) }
        }

//        self.configureTransformer("/objects/*", atStage: .model, action: .appendToExisting, description: "realm") {
//            try! self.save($0.content)
//        }

//        self.configureTransformer("/exoplanets/*", atStage: .model, action: .appendToExisting, description: "realm") {
//            try! self.save($0.content)
//        }

//        self.configureTransformer("/observingsites/*", atStage: .model, action: .appendToExisting, description: "realm") {
//            try! self.save($0.content)
//        }

//        self.configureTransformer("/observingsites/", atStage: .model, action: .appendToExisting, description: "realm-collection") {
//            ($0.content as [AnyObject]).map { try! self.save($0.content) }
//        }
    }
    
    // Auth
    
    @discardableResult
    public func login(username: String, password: String) -> Request {
        return self.resource("/auth/login/").request(.post, json: ["username": username, "password": password])
    }

    @discardableResult
    public func logout() -> Request {
        return self.resource("/auth/logout/").request(.post)
    }

    // Singles
    
    public func observeObjectResource(withName name: String, observer: AnyObject, closure: @escaping Siesta.ResourceObserverClosure)  {
        let resource = self.resource("/objects/\(name)")
        resource.addObserver(owner: observer, closure: closure)
        resource.loadIfNeeded()
    }

    public func observeExoplanetResource(withName name: String, observer: AnyObject, closure: @escaping Siesta.ResourceObserverClosure)  {
        let resource = self.resource("/exoplanets/\(name)")
        resource.addObserver(owner: observer, closure: closure)
        resource.loadIfNeeded()
    }

    public func observeObservingSiteResource(withUUID uuid: String, observer: AnyObject, closure: @escaping Siesta.ResourceObserverClosure)  {
        let resource = self.resource("/observingsites/\(uuid)")
        resource.addObserver(owner: observer, closure: closure)
        resource.loadIfNeeded()
    }

    
    // Collections
    
    public func observeObservingSitesResource(observer: AnyObject, closure: @escaping Siesta.ResourceObserverClosure)  {
        let resource = self.resource("/observingsites/")
        resource.addObserver(owner: observer, closure: closure)
        resource.loadIfNeeded()
    }
    
    public func localObjects() -> Results<AstronomicalObject> {
        let realm = try! Realm(configuration: self.realmConfiguration)
        return realm.objects(AstronomicalObject.self)
    }
    
    internal func getAll<T: Object>(ofType: T.Type) -> Results<T>? {
        let realm = try! Realm(configuration: self.realmConfiguration)
        return realm.objects(T.self)
    }

    // Realm
    
    @discardableResult
    internal func save(_ obj: Object) throws -> Object {
        let realm = try! Realm(configuration: self.realmConfiguration)
        try realm.write {
            realm.add(obj, update: true)
        }
        return obj
    }
    
    internal func getObject<T: Object>(ofType: T.Type, withPrimaryKey key: String) -> T? {
        let realm = try! Realm(configuration: self.realmConfiguration)
        return realm.object(ofType: T.self, forPrimaryKey: key)
    }

}

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
}

public enum APIVersion: String {
    case one = "1"
}

public enum ArcsecondResourceEvent {
    case remote(Siesta.ResourceEvent)
    case local(Arcsecond.ArcsecondResourceEvent.StorageEvent)
    
    public enum StorageEvent: String {
        case simpleQuery
    }
}

public typealias BaseResourceClosure = (Object?, ArcsecondResourceEvent) -> ()
public typealias AstronomicalObjectResourceClosure = (AstronomicalObject?, ArcsecondResourceEvent) -> ()
public typealias ExoplanetObjectResourceClosure = (Exoplanet?, ArcsecondResourceEvent) -> ()
public typealias ObservingSitesResourceClosure = ([ObservingSite]?, ArcsecondResourceEvent) -> ()

public class ArcsecondService : Service {
    public let version: APIVersion
    public static let sharedDefault: ArcsecondService = { return ArcsecondService() }()
    public static let sharedStagingDefault: ArcsecondService = { return ArcsecondService(usingVersion: .one, andSource: .staging) }()
    public static let sharedLocalDefault: ArcsecondService = { return ArcsecondService(usingVersion: .one, andSource: .localhost) }()
    
    private let realmConfiguration: Realm.Configuration
    
    public init(usingVersion version: APIVersion = .one, andSource source: APISource = .production) {
        self.version = version
        
        let filename = "arcsecond.\(version.rawValue).realm"
        let fileurl = URL(fileURLWithPath: RLMRealmPathForFile(filename), isDirectory: false)
        self.realmConfiguration = Realm.Configuration(fileURL: fileurl)
        
        super.init(baseURL: source.rawValue)
        
        self.configure {
            $0.expirationTime = 86400.0  // default is 30 seconds 
        }
        
        self.configureTransformer("/\(self.version.rawValue)/objects/*") {
            AstronomicalObject(value: try AstronomicalObjectValidator(json: $0.content))
        }
        
        self.configureTransformer("/\(self.version.rawValue)/exoplanets/*") {
            Exoplanet(value: $0.content)
        }
        
        self.configureTransformer("/\(self.version.rawValue)/observingsites/") {
            ($0.content as [AnyObject]).map { ObservingSite(value: $0) }
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
        let serviceResource = self.resource("/\(self.version.rawValue)/\(path)/\(name)")
        
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
    
    public func exoplanetResource(named name: String, closure: @escaping ExoplanetObjectResourceClosure) -> Siesta.Resource {
        let path = "exoplanets"
        let serviceResource = self.resource("/\(self.version.rawValue)/\(path)/\(name)")
        
        if let planet = self.get(named: name, ofType: Exoplanet.self) {
            closure(planet, .local(.simpleQuery))
        }
        else {
            serviceResource.addObserver(owner: self) {
                [weak self] resource, event in
                var planet: Exoplanet? = nil
                
                switch event {
                case .newData(.network):
                    planet = resource.latestData!.content as? Exoplanet
                    try! self?.save(planet!)
                default:
                    break
                }
                
                closure(planet, .remote(event))
            }
            serviceResource.loadIfNeeded()
        }
        
        return serviceResource
    }

    // Collections
    
    internal func getAll<T: Object>(ofType: T.Type) -> Results<T>? {
        let realm = try! Realm(configuration: self.realmConfiguration)
        return realm.objects(T.self)
    }

    public func observingSites(closure: @escaping ObservingSitesResourceClosure) -> Siesta.Resource {
        let path = "observingsites"
        let serviceResource = self.resource("/\(self.version.rawValue)/\(path)/")

        if let sites = self.getAll(ofType: ObservingSite.self), sites.count > 0 {
            closure(Array(sites), .local(.simpleQuery))
        }
        else {
            serviceResource.addObserver(owner: self) {
                [weak self] resource, event in
                var sites: [ObservingSite]? = nil
                
                switch event {
                case .newData(.network):
                    sites = resource.latestData!.content as? [ObservingSite]
                    sites?.forEach { try! self?.save($0) }
                default:
                    break
                }
                
                closure(sites, .remote(event))
            }
            serviceResource.loadIfNeeded()
        }
        
        return serviceResource
    }
    
    public func localObjects() -> Results<AstronomicalObject> {
        let realm = try! Realm(configuration: self.realmConfiguration)
        return realm.objects(AstronomicalObject.self)
    }
}

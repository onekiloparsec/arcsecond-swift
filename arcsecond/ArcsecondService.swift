//
//  ArcsecondService.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 11/09/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import Siesta
import Argo
import PromiseKit

public class ArcsecondService : Service {
    public let APIVersion: String
    
    public var exoplanets: Resource { return self.resource("/\(self.APIVersion)/exoplanets/") }
    public var observingSites: Resource { return self.resource("/\(self.APIVersion)/observingsites/") }
    
    public static let sharedDefault: ArcsecondService = { return ArcsecondService() }()
    
    public init(withAPIVersion version: String = "1") {
        self.APIVersion = version
        super.init(baseURL: "http://api.arcsecond.io")
        
        self.configure {
            $0.config.expirationTime = 86400.0  // default is 30 seconds
        }
        
        self.configureTransformer("/\(self.APIVersion)/objects/*") {
            (content: NSDictionary, _) -> AstronomicalObject? in
            decode(content)
        }
        
        self.configureTransformer("/\(self.APIVersion)/exoplanets/*") {
            (content: NSData, _) -> Exoplanet? in
            decode(content)
        }
    }
    
    public func object(name: String) -> Promise<AstronomicalObject> {
        return Promise { fulfill, reject in
            let resource = self.resource("/\(self.APIVersion)/objects/\(name)")
            resource.addObserver(owner: self) { resource, event in
                if case .NewData = event {
                    fulfill(resource.latestData!.content as! AstronomicalObject)
                }
                else if case .Error = event {
                    reject(resource.latestError!)
                }
            }
            resource.loadIfNeeded()
        }
    }
    
    public func exoplanet(name: String) -> Promise<Exoplanet> {
        return Promise { fulfill, reject in
            let resource = self.exoplanets.child(name)
            resource.addObserver(owner: self) { resource, event in
                if case .NewData = event {
                    fulfill(resource.latestData!.content as! Exoplanet)
                }
                else if case .Error = event {
                    reject(resource.latestError!)
                }
            }
            resource.loadIfNeeded()            
        }
    }
    
//    public func observingSite(name: String) -> Resource {
//        return self.observingSites.child(name)
//    }
//    
//    public func telegrams(ofType telType: TelegramType) -> Resource {
//        switch telType {
//        case .ATel:
//            return self.resource("/\(self.APIVersion)/telegrams/ATel")
//        }
//    }
//    
//    public func telegram(ofType telType: TelegramType, withIdentifier identifier: String) -> Resource {
//        return self.telegrams(ofType: telType).child(identifier)
//    }
}

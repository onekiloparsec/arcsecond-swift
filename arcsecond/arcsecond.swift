//
//  arcsecond.swift
//  arcsecond
//
//  Created by Cédric Foellmi on 15/08/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

import Foundation
import Siesta

public enum TelegramType {
    case ATel
}

public class Arcsecond : Service {
    public let APIVersion: String
    
    public var exoplanets: Resource { return self.resource("/\(self.APIVersion)/exoplanets/") }
    public var observingSites: Resource { return self.resource("/\(self.APIVersion)/observingsites/") }
    
    public init(withAPIVersion version: String = "1") {
        self.APIVersion = version
        super.init(baseURL: "http://api.arcsecond.io")
    }

    public func object(name: String) -> Resource {
        return self.resource("/\(self.APIVersion)/objects/\(name)")
    }

    public func exoplanet(name: String) -> Resource {
        return self.exoplanets.child(name)
    }

    public func observingSite(name: String) -> Resource {
        return self.observingSites.child(name)
    }
    
    public func telegrams(ofType telType: TelegramType) -> Resource {
        switch telType {
        case .ATel:
            return self.resource("/\(self.APIVersion)/telegrams/ATel")
        }
    }
    
    public func telegram(ofType telType: TelegramType, withIdentifier identifier: String) -> Resource {
        return self.telegrams(ofType: telType).child(identifier)
    }
}


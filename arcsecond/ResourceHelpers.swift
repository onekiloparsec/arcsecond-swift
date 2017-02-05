//
//  ResourceHelpers.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 05/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import Foundation
import Siesta
import RealmSwift
import Realm

// Waiting for automatic typing (Swift 4?)
// See http://bustoutsolutions.github.io/siesta/guide/faq/#roadmap

public extension TypedContentAccessors where Self: Resource {

    public var astronomicalObject: AstronomicalObject? {
        return self.typedContent() as AstronomicalObject?
    }

    public var astronomicalObjects: [AstronomicalObject]? {
        return self.typedContent() as [AstronomicalObject]?
    }

    public var exoplanet: Exoplanet? {
        return self.typedContent() as Exoplanet?
    }

    public var exoplanets: [Exoplanet]? {
        return self.typedContent() as [Exoplanet]?
    }

    public var observingSite: ObservingSite? {
        return self.typedContent() as ObservingSite?
    }

    public var observingSites: [ObservingSite]? {
        return self.typedContent() as [ObservingSite]?
    }

    //    public var observingSite: ObservingSite? {
    //        if let uuid = self.typedContent() as String? {
    //            return (self.service as! ArcsecondService).getObject(ofType: ObservingSite.self, withPrimaryKey: uuid)
    //        }
    //        return nil
    //    }
}

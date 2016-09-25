//
//  Coordinates.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 11/09/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Coordinates {
    public let system: String
//    public let rightAscension: Double
//    public let rightAscensionUnits: String
//    public let declination: Double
//    public let declinationUnits: String
//    public let epoch: Double
//    public let equinox: Double
    
    init?(json: [String: Any]?) throws {
        guard let sys = json?["system"] as? String else {
            throw SerializationError.missing("system")
        }
        
        self.system = sys
        
//        guard let self.rightAscension = json?["right_ascension"] as? Double,
//            let self.declination = json?["declination"] as? Double
//        else {
//            throw SerializationError.missing("right_ascension or declination")
//        }
//        
//        if let self.rightAscensionUnits = json?["right_ascension_units"] as? String {
//            guard contains(["degrees", "deg", "º", "hours", "h"], raUnits) else {
//                throw SerializationError.invalid("right_ascension_units", raUnits)
//            }
//        }
//        else {
//            raUnits = "degrees"
//        }
//
//        if let decUnits = json?["declination_units"] as? String {
//            guard contains(["degrees", "deg", "º"], declinationUnits) else {
//                throw SerializationError.invalid("declination_units", decUnits)
//            }
//        }
//        else {
//            decUnits = "degrees"
//        }
//
//        
//        let useDegreesForRA = contains(["degrees", "deg", "º"], raUnits)
//        rightAscensionValidRange = (useDegreesForRA) ? 0.0...360.0 : 0.0...24.0
//        
//        guard case (rightAscensionValidRange, -90...90) = (rightAscension, declination) else {
//            throw SerializationError.invalid("coordinates", coordinates)
//        }
//
//        if let epoch = json?["epoch"] as? Double {
//            guard case (1900.0...2100.0) = (epoch) else {
//                throw SerializationError.invalid("epoch", epoch)
//            }
//        }
//        else {
//            
//        }
//        
//        if let equinox = json?["equinox"] as? Double {
//            guard case (1900.0...2100.0) = (epoch) else {
//                throw SerializationError.invalid("equinox", epoch)
//            }
//        }
//        else {
//            
//        }
    }
}


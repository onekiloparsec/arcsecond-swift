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
    
    init(json: [String: Any]?) throws {
        guard let _system = json?["system"] as? String else {
            throw SerializationError.missing("system")
        }
        
        self.system = _system

//        guard let _rightAscension = json?["right_ascension"] as? Double,
//            let _declination = json?["declination"] as? Double
//            else {
//                throw SerializationError.missing("right_ascension or declination")
//        }
//        
//        self.rightAscension = _rightAscension
//        self.declination = _declination
//        
//        // Fallback to default value if not present
//        if let _rightAscensionUnits = json?["right_ascension_units"] as? String {
//            guard let _ = ["degrees", "deg", "º", "hours", "h"].index(of: _rightAscensionUnits) else {
//                throw SerializationError.invalid("right_ascension_units", _rightAscensionUnits)
//            }
//            self.rightAscensionUnits = _rightAscensionUnits
//        }
//        else {
//            self.rightAscensionUnits = "degrees"
//        }
//
//        // Fallback to default value if not present
//        if let _declinationUnits = json?["declination_units"] as? String {
//            guard let _ = ["degrees", "deg", "º"].index(of: _declinationUnits) else {
//                throw SerializationError.invalid("declination_units", _declinationUnits)
//            }
//            self.declinationUnits = _declinationUnits
//        }
//        else {
//            self.declinationUnits = "degrees"
//        }
//
//        
//        let useDegreesForRA = (["degrees", "deg", "º"].index(of: self.rightAscensionUnits) != nil)
//        let rightAscensionValidRange = (useDegreesForRA) ? 0.0...360.0 : 0.0...24.0
//        let declinationValidRange = -90.0...90.0
//        
//        guard case (rightAscensionValidRange, declinationValidRange) = (rightAscension, declination) else {
//            throw SerializationError.invalid("coordinates", (rightAscension, declination))
//        }
//
//        // Fallback to default value if not present
//        if let _epoch = json?["epoch"] as? Double {
//            guard case (1900.0...2100.0) = (_epoch) else {
//                throw SerializationError.invalid("epoch", _epoch)
//            }
//            self.epoch = _epoch
//        }
//        else {
//            self.epoch = StandardEpoch_J2000_0
//        }
//        
//        // Fallback to default value if not present
//        if let _equinox = json?["equinox"] as? Double {
//            guard case (1900.0...2100.0) = (_equinox) else {
//                throw SerializationError.invalid("equinox", _equinox)
//            }
//            self.equinox = _equinox
//        }
//        else {
//            self.equinox = StandardEpoch_J2000_0
//        }
    }
}


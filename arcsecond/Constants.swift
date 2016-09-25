//
//  Constants.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 17/09/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

public enum Equinox {
    case MeanEquinoxOfTheDate
    case StandardJ2000
}

public enum Season {
    case Spring
    case Summer
    case Autumn
    case Winter
}

public enum MoonPhase {
    case New
    case FirstQuarter
    case Full
    case LastQuarter
}

public typealias Days = Double
public typealias JulianDay = Double

public let JulianYear: Days = 365.25            // See p.133 of AA.
public let BesselianYear: Days = 365.2421988    // See p.133 of AA.
public let JulianDayB1950: JulianDay = 2433282.4235	// See p.133 of AA.

public let StandardEpoch_J2000_0 = 2451545.0 // See p.133 of AA.
public let StandardEpoch_B1950_0 = 2433282.4235 // See p.133 of AA.

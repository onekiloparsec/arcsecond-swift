//
//  Coordinates.swift
//  Arcsecond
//
//  Created by Cédric Foellmi on 11/09/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import RealmSwift

public class Coordinates: Object {
    public dynamic var longitude: Float = 0.0
    public dynamic var latitude: Float = 0.0
    public dynamic var height: Float = 0.0
}



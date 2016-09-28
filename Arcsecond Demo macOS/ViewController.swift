//
//  ViewController.swift
//  Arcsecond Demo macOS
//
//  Created by Cédric Foellmi on 09/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Cocoa
import Arcsecond

class ViewController: NSViewController {
    @IBOutlet weak var nameLabel, favoriteColorLabel: NSTextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        _ = Arcsecond.object("HD 5980").then { object in
            Swift.print("--> Just received an object: \(object)")
        }
        
        _ = Arcsecond.exoplanet("51 Peg b").then { exoplanet in
            Swift.print("--> Just received an exoplanet: \(exoplanet)")
        }
    }
}


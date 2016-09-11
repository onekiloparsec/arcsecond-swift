//
//  ViewController.swift
//  Arcsecond Demo macOS
//
//  Created by Cédric Foellmi on 09/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Cocoa
import Arcsecond
import Siesta
import PromiseKit

class ViewController: NSViewController {
    @IBOutlet weak var nameLabel, favoriteColorLabel: NSTextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        Arcsecond.object("HD 5980").then { object in
            Swift.print("\(object)")
        }
    }
}


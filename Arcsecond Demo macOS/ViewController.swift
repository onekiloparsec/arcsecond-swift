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

class ViewController: NSViewController {
    @IBOutlet weak var nameLabel, favoriteColorLabel: NSTextField!
    
    let arcsecond = Arcsecond()
    var hd5980: Resource? = nil
    var exoplanet51Pegb: Resource? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hd5980 = self.arcsecond.object("HD 5980")
        self.exoplanet51Pegb = self.arcsecond.exoplanet("51 Peg b")
        
        self.hd5980!.addObserver(owner: self) { (resource, event) in
            print("resource \(resource.jsonDict["aliases"])")
        }
        
        self.exoplanet51Pegb?.addObserver(owner: self) { (resource, event) in
            print ("exoplanet \(resource.jsonDict)")
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.hd5980!.loadIfNeeded()
        self.exoplanet51Pegb!.loadIfNeeded()
    }

    override func viewDidLayout() {
        super.viewDidLayout()
    }
    

}


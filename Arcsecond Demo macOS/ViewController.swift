//
//  ViewController.swift
//  Arcsecond Demo macOS
//
//  Created by Cédric Foellmi on 09/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Cocoa
import Siesta
import Arcsecond
import RealmSwift

class ViewController: NSViewController {
    @IBOutlet weak var usernameField: NSTextField!
    @IBOutlet weak var passwordField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        _ = Arcsecond.objectResource(named: "BAT99 128") { object, event in
//            print("\(event)")
//            print("\(object)")
//        }
        
//        _ = Arcsecond.exoplanetResource(named: "51 Peg b") { exoplanet, event in
//            print("\(event)")
//            print("\(exoplanet)")
//        }
        
//        _ = ArcsecondService.sharedLocalDefault.observingSites { sites, event in
//            print("\(event)")
//            print("\(sites)")
//        }

//        ArcsecondService.sharedLocalDefault.observeObservingSiteResource(withUUID: "D0B9DBD1-BD80-4EF6-95A4-FD2CFAEA65F5", observer: self) {
//            (resource, event) in
//            Swift.print("-> \(resource.observingSite)")
//        }
        
        ArcsecondService.sharedDefault.observeObservingSitesResource(observer: self) { (resource, event) in
            if case .newData = event {
                Swift.print("-> resources \(String(describing: resource.observingSites)), event \(event)")
                Swift.print("-> resources \(String(describing: resource.observingSites!.first!.coordinates)), event \(event)")
            }
        }
    }
    
    
    @IBAction func login(_ sender: Any) {
        Arcsecond.login(username: self.usernameField.stringValue, password: self.passwordField.stringValue)
            .onFailure({ error in
                print(error)
            })
        .onSuccess({ entity in
            print(entity)
        })        
    }
}


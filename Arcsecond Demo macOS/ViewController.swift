//
//  ViewController.swift
//  Arcsecond Demo macOS
//
//  Created by Cédric Foellmi on 09/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Cocoa
import Arcsecond
import RealmSwift

class ViewController: NSViewController {
    @IBOutlet weak var usernameField: NSTextField!
    @IBOutlet weak var passwordField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _ = Arcsecond.objectResource(named: "BAT99 128") { object, event in
            print("\(event)")
            print("\(object)")
        }
    }
    
    @IBAction func login(_ sender: Any) {
        _ = Arcsecond.login(username: self.usernameField.stringValue, password: self.passwordField.stringValue)
            .onFailure({ error in
                print(error)
            })
        .onSuccess({ entity in
            print(entity)
        })        
    }
}


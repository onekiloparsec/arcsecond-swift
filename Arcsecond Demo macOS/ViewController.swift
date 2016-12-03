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

//        _ = Arcsecond.object("BAT99 129").then { object -> Void in
//            Swift.print("--> Just received an object: \(object)")
//            do  {
//             try Arcsecond.save(object)
//            }
//            catch Realm.Error.fail {
//                Swift.print("file exists")
//            }
//            catch Realm.Error.fileAccess {
//                Swift.print("file exists")
//            }
//            catch Realm.Error.filePermissionDenied {
//                Swift.print("file exists")
//            }
//            catch Realm.Error.fileExists {
//                Swift.print("file exists")
//            }
//            catch Realm.Error.fileNotFound {
//                Swift.print("file exists")
//            }
//            catch Realm.Error.incompatibleLockFile {
//                Swift.print("file exists")
//            }
//            catch Realm.Error.fileFormatUpgradeRequired {
//                Swift.print("file exists")
//            }
//            catch Realm.Error.addressSpaceExhausted {
//                Swift.print("file exists")
//            }
//            catch Realm.Error.schemaMismatch {
//                Swift.print("file exists")
//            }
//            Swift.print(Arcsecond.objects())
//        }
        
        
//        _ = Arcsecond.exoplanet("51 Peg b").then { exoplanet in
//            Swift.print("--> Just received an exoplanet: \(exoplanet)")
//        }
    }
    
    @IBAction func login(_ sender: Any) {
        _ = Arcsecond.login(username: self.usernameField.stringValue, password: self.passwordField.stringValue).then { result in
            print(result)
        }
    }
}


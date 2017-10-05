//
//  AppDelegate.swift
//  FaceRecognition
//
//  Created by Vitaliy Ampilogov on 10/3/17.
//  Copyright © 2017 Vitaliy Ampilogov. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let userPasswordManager = Locator.shared.userPasswordManager
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Setup user password here. In real life, it sould be receved from password form
        let userInput = "nk$8[TY=9$7x`Yfv"
        userPasswordManager.savePassword(userInput)
        
        return true
    }
    
    var window: UIWindow?
}


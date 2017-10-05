//
//  UserPasswordManager.swift
//  FaceRecognition
//
//  Created by Vitaliy Ampilogov on 10/5/17.
//  Copyright © 2017 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

protocol UserPasswordManagerProtocol {
    
    func savePassword(_ password: String)
    func readPassword() -> String?
}

class UserPasswordManager: UserPasswordManagerProtocol {
    
    private let passwordKey = "passwordKey"
    
    func savePassword(_ password: String) {
        KeychainWrapper.standard.set(password, forKey: passwordKey)
    }
    
    func readPassword() -> String? {
        return KeychainWrapper.standard.string(forKey: passwordKey)
    }
}

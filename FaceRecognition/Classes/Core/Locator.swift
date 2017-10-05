//
//  Locator.swift
//  FaceRecognition
//
//  Created by Vitaliy Ampilogov on 10/3/17.
//  Copyright © 2017 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import  AVFoundation

class Locator {
    
    init(){
        
    }
    
    static let shared = Locator()
    
    // MARK: - Logic layer
    
    var permissionManager: PermissionManagerProtocol {
        return PermissionManager()
    }
    
    var userPasswordManager: UserPasswordManagerProtocol {
        return UserPasswordManager()
    }
    
    var capturePhotoHandler: AVCapturePhotoCaptureDelegate {
        return CapturePhotoHandler(storage: securityStorage)
    }
    
    var captureSessionContainer: CaptureSessionContainerProtocol {
        return CaptureSessionContainer()
    }
    
    // MARK: - Core layer
    
    var securityStorage: SecurityStorageProtocol {
        guard let password = userPasswordManager.readPassword() else {
            fatalError("Can't create SecurityStorage without storage")
        }
        
        return SecurityStorage(password: password)
    }
}

//
//  PermissionManager.swift
//  FaceRecognition
//
//  Created by Vitaliy Ampilogov on 10/3/17.
//  Copyright © 2017 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import AVFoundation

protocol PermissionManagerProtocol {

    func checkCameraAuthorization(_ completionHandler: @escaping ((_ authorized: Bool) -> Void))    
}

class PermissionManager: PermissionManagerProtocol {
    
    func checkCameraAuthorization(_ completionHandler: @escaping ((_ authorized: Bool) -> Void)) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completionHandler(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { success in
                completionHandler(success)
            })
        case .denied:
            completionHandler(false)
        case .restricted:
            completionHandler(false)
        }
    }
}

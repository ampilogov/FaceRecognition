//
//  CapturePhotoOutputProvider.swift
//  FaceRecognition
//
//  Created by Vitaliy Ampilogov on 10/5/17.
//  Copyright © 2017 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import AVFoundation

protocol CaptureSessionContainerProtocol {
    var photoOutput: AVCapturePhotoOutput { get }
    var session: AVCaptureSession { get }
}

class CaptureSessionContainer: CaptureSessionContainerProtocol {
    
    let photoOutput = AVCapturePhotoOutput()
    
    lazy var session: AVCaptureSession = {
        let session = AVCaptureSession()
        
        // Get video input for the camera.
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
            let videoInput = try? AVCaptureDeviceInput(device: device) else {
                fatalError("Unable to obtain video input for default camera.")
        }
        
        // Configure the session.
        session.beginConfiguration()
        session.sessionPreset = .photo
        session.addInput(videoInput)
        session.addOutput(photoOutput)
        session.commitConfiguration()
        
        return session
    }()
    
}

//
//  PhotoCaptureHandler.swift
//  FaceRecognition
//
//  Created by Vitaliy Ampilogov on 10/5/17.
//  Copyright © 2017 Vitaliy Ampilogov. All rights reserved.
//

import UIKit
import AVFoundation

class CapturePhotoHandler: NSObject, AVCapturePhotoCaptureDelegate {
    let storage: SecurityStorageProtocol
    let captureQueue = DispatchQueue(label: "captureQueue")
    
    init(storage: SecurityStorageProtocol) {
        self.storage = storage
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        captureQueue.async {
            if let imageData = photo.fileDataRepresentation() {
                let dateString = String(describing: photo.timestamp.value)
                self.storage.save(imageData, fileName: dateString)
            }
        }
    }
}

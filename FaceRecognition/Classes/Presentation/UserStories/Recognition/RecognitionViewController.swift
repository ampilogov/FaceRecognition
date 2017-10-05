//
//  RecognitionViewController.swift
//  FaceRecognition
//
//  Created by Vitaliy Ampilogov on 10/3/17.
//  Copyright © 2017 Vitaliy Ampilogov. All rights reserved.
//

import UIKit
import AVFoundation

class RecognitionViewController: UIViewController {

    // Dependencies
    private let permissionManager = Locator.shared.permissionManager
    private let captureSessionContiner = Locator.shared.captureSessionContainer
    private lazy var photoCaptureHandler = Locator.shared.capturePhotoHandler
    
    // UI
    @IBOutlet weak var videoView: VideoPreviewView!
    @IBOutlet weak var countLabel: UILabel!
    
    // Values
    var photosCount = 0
    
    // MARK: - Livecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.videoView.session = captureSessionContiner.session
    }
    
    // MARK: - Actions
    
    @IBAction private func recognizeAction(_ sender: UIButton) {
        
        // Check permission
        self.permissionManager.checkCameraAuthorization { (authorized) in
            guard authorized else { return }
            self.startRecognize()
        }
    }
    
    private func startRecognize() {
        UIView.animate(withDuration: 0.3) {
            self.videoView.alpha = 1
        }
        self.captureSessionContiner.session.startRunning()
        self.takePhotos()
    }
    
    private func stopRecognize() {
        self.captureSessionContiner.session.stopRunning()
        UIView.animate(withDuration: 0.3) {
            self.videoView.alpha = 0
        }
    }
    
    func takePhotos(){
        guard photosCount < 10 else {
            photosCount = 0
            stopRecognize()
            return
        }
        photosCount += 1
        countLabel.text = String(photosCount)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])
            self.captureSessionContiner.photoOutput.capturePhoto(with: photoSettings, delegate: self.photoCaptureHandler)
            self.takePhotos()
        }
    }
}


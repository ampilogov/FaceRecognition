//
//  VideoPreviewView.swift
//  FaceRecognition
//
//  Created by Vitaliy Ampilogov on 10/3/17.
//  Copyright © 2017 Vitaliy Ampilogov. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPreviewView: UIView {
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    var session: AVCaptureSession? {
        get { return videoPreviewLayer.session }
        set { videoPreviewLayer.session = newValue }
    }
}

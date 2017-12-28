//
//  ViewController.swift
//  CameraPractice
//
//  Created by Higher Visibility on 28/12/2017.
//  Copyright © 2017 Higher Visibility. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var imageDisplay: UIImageView!
    
    
    
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCaptureStillImageOutput()
    var layer = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        
        
        for device in devices{
        
            if device.position == .Back{
            
                do{
                    
                    let input = try AVCaptureDeviceInput(device: device as! AVCaptureDevice)
                    
                    if captureSession.canAddInput(input){
                    
                        captureSession.addInput(input)
                        
                        sessionOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
                        
                        if captureSession.canAddOutput(sessionOutput){
                        
                            captureSession.addOutput(sessionOutput)
                            captureSession.startRunning()
                            
                            layer = AVCaptureVideoPreviewLayer(session: captureSession)
                            layer.videoGravity = AVLayerVideoGravityResizeAspectFill
                            layer.connection.videoOrientation = .Portrait
                            self.cameraView.layer.addSublayer(layer)
                            layer.position = CGPoint(x: self.cameraView.frame.width / 2, y: self.cameraView.frame.height / 2)
                            layer.bounds = self.cameraView.frame
                            
                        }
                        
                    }
                
                }catch {
                
                
                
                }
            
            
            }
        
        }
        
    }

   

    @IBAction func takephoto_pressed(sender: UIButton) {
        
        
        if let session = sessionOutput.connectionWithMediaType(AVMediaTypeVideo){
        
            
            sessionOutput.captureStillImageAsynchronouslyFromConnection(session, completionHandler: { (buffer, error) in
                
                
                let imagedata = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer)
                
                self.imageDisplay.image = UIImage(data: imagedata)
                
            })
        
        }
        
        
    }

}


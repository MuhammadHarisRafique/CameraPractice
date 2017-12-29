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
    var inputdevice  = AVCaptureDeviceInput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    @IBAction func frontCamera(sender: UIButton) {
       self.getfrontCamera()
        
    }
    override func viewDidAppear(animated: Bool) {
        self.getBackCamera()
    }
    @IBAction func backCamerapressed(sender: UIButton) {
        self.getBackCamera()
    }

    func getfrontCamera(){
        
        captureSession.removeInput(self.inputdevice)
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        
        for device in devices{
            
            if device.position == .Front{
                
                do{
                    
                    self.inputdevice = try AVCaptureDeviceInput(device: device as! AVCaptureDevice)
                    
                    
                    if captureSession.canAddInput(self.inputdevice){
                        
                        captureSession.addInput(self.inputdevice)
                        
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
    
    func getBackCamera(){
        
         captureSession.removeInput(self.inputdevice)
        
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        
        
        for device in devices{
            
            if device.position == .Back{
                
                do{
                    
                    self.inputdevice = try AVCaptureDeviceInput(device: device as! AVCaptureDevice)
                    
                    if captureSession.canAddInput(self.inputdevice){
                        
                        captureSession.addInput(self.inputdevice)
                        
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


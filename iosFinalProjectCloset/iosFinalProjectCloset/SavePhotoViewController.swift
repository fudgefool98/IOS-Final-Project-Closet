//
//  SavePhotoViewController.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 11/30/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class SavePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let captureSession = AVCaptureSession()
    
    var captureDevice: AVCaptureDevice?
    
    var videoDeviceInput:AVCaptureDeviceInput?
    
    var discoverySession: AVCaptureDevice.DiscoverySession?
    
    var photo: UIImage?
    
    var photoSampleBuffer:CMSampleBuffer?
    
    let sessionQueue = DispatchQueue(label: "session queue",
                                     attributes: [],
                                     target: nil) // Communicate with the session and other session objects on this queue.
    
    private enum SessionSetupResult {
        case success
        case notAuthorized
        case configurationFailed
    }
    
    private var setupResult: SessionSetupResult = .success
    
    
    var previewView:AVCaptureVideoPreviewLayer?
    
    private let photoOutput = AVCapturePhotoOutput()
    
    
    @IBAction func photoButtonWasPressed(_ sender: Any) {
        #if (!arch(x86_64))
            //Set orientatrion how the view is
            //Lots of set up before photo capture can happen
            let videoPreviewLayerOrientation = previewView?.connection?.videoOrientation
            sessionQueue.async {
                let pixelFormatType = NSNumber(value: kCVPixelFormatType_32BGRA)
                guard self.photoOutput.__availablePhotoPixelFormatTypes.contains(pixelFormatType) else { return}
                
                let photoSettings = AVCapturePhotoSettings(format: [kCVPixelBufferPixelFormatTypeKey as String:pixelFormatType])
                
                //var photoSettings = AVCapturePhotoSettings(format: <#T##[String : Any]?#>)
                
                if let check = self.captureDevice?.isFlashAvailable,
                    check{
                    photoSettings.flashMode = .auto
                }
                photoSettings.isAutoStillImageStabilizationEnabled = true
                photoSettings.isHighResolutionPhotoEnabled = true
                if let photoOutputConnection = self.photoOutput.connection(with: AVMediaType.video) {
                    photoOutputConnection.videoOrientation = videoPreviewLayerOrientation!
                }
                
                
                
                self.photoOutput.capturePhoto(with: photoSettings, delegate: self)
            }
            
            
            
            
            //let videoPreviewLayerOrientation =  //.videoPreviewLayer.connection?.videoOrientation
            
            
        #endif
    }
    
    //use image picker to select an image
    let imagePicker = UIImagePickerController()
    
    @IBAction func ChoosePhotoWasPressed(_ sender: Any) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photo = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "showImage", sender: self)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        //Take good photos
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        
        //Check authorization. Code taken from apple
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            // The user has previously granted access to the camera.
            break
            
        case .notDetermined:
            /*
             The user has not yet been presented with the option to grant
             video access. We suspend the session queue to delay session
             setup until the access request has completed.
             
             Note that audio access will be implicitly requested when we
             create an AVCaptureDeviceInput for audio during session setup.
             */
            //            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { [unowned self] granted in
                if !granted {
                    self.setupResult = .notAuthorized
                }
            })
            
        default:
            // The user has previously denied access.
            setupResult = .notAuthorized
        }
        
        discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera,AVCaptureDevice.DeviceType.builtInDualCamera], mediaType: nil, position: .back)
        
        let devices = discoverySession?.devices
        
        //ALERT: code after this may break because of return
        guard let safeDevices = devices else {
            return
        }
        for device in safeDevices {
            //            guard let device = device  else {
            //                continue
            //            }
            if (device.hasMediaType(AVMediaType.video)) {
                if (device.position == AVCaptureDevice.Position.back) {
                    captureDevice = device
                }
                
            }
            if captureDevice != nil {
                beginSession()
            }
            
        }
    }
    //MARK: configure session main function
    
    func configureSession() {
        captureSession.beginConfiguration()
        
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        do {
            var defaultVideoDevice: AVCaptureDevice?
            
            
            defaultVideoDevice = captureDevice
            let videoDeviceInput = try AVCaptureDeviceInput(device: defaultVideoDevice!)
            
            if captureSession.canAddInput(videoDeviceInput) {
                captureSession.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
                
            } else {
                print("Could not add video device input to the session")
                setupResult = .configurationFailed
                captureSession.commitConfiguration()
                return
            }
        } catch {
            print("Could not create video device input: \(error)")
            setupResult = .configurationFailed
            captureSession.commitConfiguration()
            return
        }
        
        
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
            
            photoOutput.isHighResolutionCaptureEnabled = true
            //photoOutput.isLivePhotoCaptureEnabled = photoOutput.isLivePhotoCaptureSupported
            //photoOutput.isDepthDataDeliveryEnabled = photoOutput.isDepthDataDeliverySupported
            //ivePhotoMode = photoOutput.isLivePhotoCaptureSupported ? .on : .off
            //depthDataDeliveryMode = photoOutput.isDepthDataDeliverySupported ? .on : .off
            
        } else {
            print("Could not add photo output to the session")
            setupResult = .configurationFailed
            captureSession.commitConfiguration()
            return
        }
        
        captureSession.commitConfiguration()
        
        
        
    }
    
    private var orientationMap: [UIDeviceOrientation : AVCaptureVideoOrientation] = [
        .portrait           : .portrait,
        .portraitUpsideDown : .portraitUpsideDown,
        .landscapeLeft      : .landscapeRight,
        .landscapeRight     : .landscapeLeft,
        ]
    
    
    func updateVideoOrientationForDeviceOrientation() {
        if let videoPreviewLayerConnection = previewView?.connection {
            let deviceOrientation = UIDevice.current.orientation
            guard let newVideoOrientation = orientationMap[deviceOrientation],
                deviceOrientation.isPortrait || deviceOrientation.isLandscape
                else { return }
            videoPreviewLayerConnection.videoOrientation = newVideoOrientation
        }
        
    }
    
    func beginSession() {
        //var err: NSError? = nil
        configureSession()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer)
        previewLayer.frame = self.view.layer.frame
        self.previewView = previewLayer
        captureSession.startRunning()
        previewView?.session = captureSession
        updateVideoOrientationForDeviceOrientation()
        //configureDevice()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Lock view orientation when appears
        //AppUtility.lockOrientation(.portrait)
        
    }
    
    //Must allow orientation to be normal afterwards.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //AppUtility.lockOrientation(.all)
    }
    
    //Pass photo forwards
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return }
        
        switch identifier {
        case "showImage":
            if let navController = segue.destination as? UINavigationController, let destination = navController.viewControllers.first as? EditItemViewController{
                if let photo = photo{
                    destination.itemPhoto.image = photo
                }
            }
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}




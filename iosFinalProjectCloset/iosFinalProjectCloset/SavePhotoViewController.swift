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

class SavePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate {
    
    //    Somewhat followed this https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/PhotoCaptureGuide/index.html
    
    
    @IBOutlet weak var takePhoto: UIButton!
    @IBOutlet weak var uploadPhoto: UIButton!
    @IBOutlet weak var closePhoto: UIButton!
    
    let captureSession = AVCaptureSession()
    var captureDevice: AVCaptureDevice?
    var videoDeviceInput:AVCaptureDeviceInput?
    var discoverySession: AVCaptureDevice.DiscoverySession?
    var photo: UIImage?
    var photoSampleBuffer:CMSampleBuffer?
    //let videoDeviceInput = defaultDevice()
    
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
        let videoDeviceInput = defaultDevice()
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        //Breaks at this next line
        if (videoDeviceInput.isFlashAvailable) {
            photoSettings.flashMode = .auto
        } else {
            print("No device available")
        }
        if !photoSettings.availablePreviewPhotoPixelFormatTypes.isEmpty {
            photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: photoSettings.availablePreviewPhotoPixelFormatTypes.first!]
        }
        snapPhoto()
        photoOutput.capturePhoto(with: photoSettings, delegate: self as! AVCapturePhotoCaptureDelegate)
        
    }
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            print("Error capturing photo: \(error)")
        } else {
            if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
                
                photo = UIImage(data: dataImage)
                performSegue(withIdentifier: "showImage", sender: self)
                print(photo!)
            }
        }
        
    }
    
    func snapPhoto() {
        
        //let videoPreviewLayerOrientation = previewView.videoPreviewLayer.connection.videoOrientation
        self.sessionQueue.async {
            // Update the photo output's connection to match the video orientation of the video preview layer.
            if self.photoOutput.connection(with: AVMediaType.video) != nil {
                //photoOutputConnection.videoOrientation = videoPreviewLayerOrientation
            
            
            let photoSettings = AVCapturePhotoSettings()
            photoSettings.isAutoStillImageStabilizationEnabled = true
            photoSettings.isHighResolutionPhotoEnabled = true
            photoSettings.flashMode = .auto
            
            self.photoOutput.capturePhoto(with: photoSettings, delegate: self as! AVCapturePhotoCaptureDelegate)
            }
        }
    }
    
    func defaultDevice() -> AVCaptureDevice {
        if let device = AVCaptureDevice.default(.builtInDuoCamera,
                                                for: AVMediaType.video,
                                                      position: .back) {
            return device // use dual camera on supported devices
        } else if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                       for: AVMediaType.video,
                                                             position: .back) {
            return device // use default back facing camera otherwise
        } else {
            fatalError("All supported devices are expected to have at least one of the queried capture devices.")
        }
    }
    
    @IBAction func closeCamera(_ sender: Any) {
        self.captureSession.stopRunning()
    }
    
    //use image picker to select an image
    let imagePicker = UIImagePickerController()
    
    @IBAction func ChoosePhotoWasPressed(_ sender: Any) {
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photo = pickedImage
        }
        imagePicker.dismiss(animated: true) {
            self.performSegue(withIdentifier: "showImage", sender: self)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        takePhoto.layer.zPosition = 1
        uploadPhoto.layer.zPosition = 1
        
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
        
    }
    
    //Must allow orientation to be normal afterwards.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    //Pass photo forwards
    
//Upload photo steps through this but does not segue successfully
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "showImage":
            if let destination = segue.destination as? EditItemViewController{
                if let photo = photo{
                    destination.photo = photo
                }
            }
        default:
            print("DEFAULT")
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func closePopUp(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
}







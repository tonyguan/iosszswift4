//
//  ViewController.swift
//  VideoRecord_AVFoundation
//
//  Created by 关东升 on 15/1/28.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

import AVFoundation
import AssetsLibrary

class ViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    var session : AVCaptureSession!
    var output : AVCaptureMovieFileOutput!
    var isRecording =  false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.session =  AVCaptureSession()
        self.session.sessionPreset = AVCaptureSessionPresetMedium
        
        let cameraDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var error : NSError?
        
        let camera = AVCaptureDeviceInput.deviceInputWithDevice(cameraDevice, error: &error) as! AVCaptureDeviceInput
        
        
        let micDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
        let mic = AVCaptureDeviceInput.deviceInputWithDevice(micDevice, error: &error) as! AVCaptureDeviceInput
        
        self.session.addInput(camera)
        self.session.addInput(mic)
        
        self.output = AVCaptureMovieFileOutput()
        
        if self.session.canAddOutput(self.output) {
            self.session.addOutput(self.output)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        previewLayer.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)
        
        self.view.layer.insertSublayer(previewLayer, atIndex:0)
        
        self.session.startRunning()
        self.isRecording = false
        self.label.text = ""
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if !self.session.running {
            self.session.startRunning()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.session.running {
            self.session.stopRunning()
        }
    }
    
    
    @IBAction func recordPressed(sender: AnyObject) {
        if !self.isRecording {
            self.button.setTitle("停止", forState: .Normal)
            self.label.text = "录制中..."
            self.isRecording = true
            
            let fileURL = self.fileURL()
            self.output.startRecordingToOutputFileURL(fileURL, recordingDelegate:self)
            
        } else {
            self.button.setTitle("录制", forState: .Normal)
            self.label.text = "停止"
            self.output.stopRecording()
            self.isRecording = false
        }
    }
    
    func fileURL() -> NSURL? {
        
        let outputPath = String(format: "%@%@", NSTemporaryDirectory(), "movie.mov")
        let outputURL = NSURL(fileURLWithPath: outputPath)
        
        let manager = NSFileManager()
        if (manager.fileExistsAtPath(outputPath)) {
            manager.removeItemAtPath(outputPath, error: nil)
        }
        
        return outputURL
    }
    
    // MARK: --AVCaptureFileOutputRecordingDelegate委托协议实现方法
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        
        if error == nil {
            var library = ALAssetsLibrary()
            library.writeVideoAtPathToSavedPhotosAlbum(outputFileURL, completionBlock: { (assetURL, error) -> Void in
                NSLog("写入错误。")
            })
        }
        
    }
    
}


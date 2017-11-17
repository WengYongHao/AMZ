
//
//  ViewController.swift
//  AmazonScanCode
//
//  Created by yonghao on 2017/8/28.
//  Copyright © 2017年 yonghao. All rights reserved.
//

import UIKit

import AVFoundation

class ViewController: UIViewController ,AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate {

    let device = AVCaptureDevice.default(for: AVMediaType.video)
    let session = AVCaptureSession()
    var layer:AVCaptureVideoPreviewLayer?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.view.backgroundColor = UIColor.green
//        let lblIntroduction = UILabel(frame: CGRect.init(x: 20, y: 180, width: 280, height: 280))
//        lblIntroduction.text = "Scan QRCode"
//        lblIntroduction.textColor = UIColor.white
//        self.view.addSubview(lblIntroduction)
//        
//        setupCamera()
        
       
    }

    
    
    @IBAction func next(_ sender: UIButton) {
        let amzScanVC = AMZScanViewController()
        
        self.navigationController?.pushViewController(amzScanVC, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupCamera() {
        //An AVCaptureSession preset suitable for medium quality output
        self.session.sessionPreset = AVCaptureSession.Preset.medium //AVCaptureSessionPresetHigh

        //This step is to ask device where it can use back camera
        var input : AVCaptureDeviceInput?
        do {
            try input = AVCaptureDeviceInput(device: device!)
        } catch {
            print(error.localizedDescription)
        }
        
        
        if session.canAddInput(input!) {
            session.addInput(input!)
        }
        
        layer = AVCaptureVideoPreviewLayer(session: session)
        layer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer?.frame = CGRect.init(x: 20, y: 180, width: 280, height: 280)
        self.view.layer.insertSublayer(self.layer!, at: 0)
        
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        if session.canAddOutput(output) {
           
            session.addOutput(output)
            output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr,AVMetadataObject.ObjectType.code128,AVMetadataObject.ObjectType.ean8,AVMetadataObject.ObjectType.upce,AVMetadataObject.ObjectType.code39,AVMetadataObject.ObjectType.pdf417,AVMetadataObject.ObjectType.aztec,AVMetadataObject.ObjectType.code93,AVMetadataObject.ObjectType.ean13,AVMetadataObject.ObjectType.code39Mod43]
        }
        
        session.startRunning()
        
    }
    
    func metadataOutput(captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        var stringValue:String?
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
        }
        
        self.session.stopRunning()
        
        let alAction = UIAlertAction.init(title: "sure", style: .default) { [weak self](action: UIAlertAction) in
            let webV = UIWebView.init()
            
            
            webV.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self?.view.addSubview(webV)
            
            let req = URLRequest.init(url: URL.init(string: "https://www.amazon.com/gp/aw/s/ref=is_s?k="+stringValue!)!)
            webV.loadRequest(req)
        }
        
        
        let alertVC = UIAlertController.init(title: nil, message: stringValue, preferredStyle: .alert)
        alertVC.addAction(alAction)
        
        self.present(alertVC, animated: true) {
            
        }

    }
    
    private func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        
        var stringValue:String?
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
        }
        
        self.session.stopRunning()

        let alAction = UIAlertAction.init(title: "sure", style: .default) { [weak self](action: UIAlertAction) in
            self?.session.startRunning()
        }
        
        
        let alertVC = UIAlertController.init(title: nil, message: stringValue, preferredStyle: .alert)
        alertVC.addAction(alAction)
        
        self.present(alertVC, animated: true) {
            
        }
    }
    

}


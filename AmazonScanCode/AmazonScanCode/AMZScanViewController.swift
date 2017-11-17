//
//  AMZScanViewController.swift
//  AmazonScanCode
//
//  Created by yonghao on 2017/8/28.
//  Copyright © 2017年 yonghao. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AMZScanViewController : UIViewController,AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate {
    
    let device = AVCaptureDevice.default(for: AVMediaType.video)
    var session = AVCaptureSession()
    var layer:AVCaptureVideoPreviewLayer?
    
    let cameraWidth: CGFloat = 266.6//UIScreen.main.bounds.size.width - 60
    lazy var cameraSize: CGRect = {
        let size = CGRect.init(x: (UIScreen.main.bounds.size.width-self.cameraWidth)/2, y: (UIScreen.main.bounds.size.height-self.cameraWidth)/2, width: self.cameraWidth, height: self.cameraWidth*2.0/3.0)
        return size
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupCamera()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.session.isRunning == false) {
            self.session.startRunning()
        }
    }
    
    func setupCamera() {
        self.session.sessionPreset = AVCaptureSession.Preset.medium //AVCaptureSessionPresetHigh
        
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
        layer?.frame = cameraSize
        self.view.layer.insertSublayer(self.layer!, at: 0)
        
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        if session.canAddOutput(output) {
            
            session.addOutput(output)
            output.metadataObjectTypes = [AVMetadataObject.ObjectType.code128, AVMetadataObject.ObjectType.qr]
        }
        
        session.startRunning()
        
        if session.isRunning {
            
            print("yyyyyy")
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        var stringValue:String?
        
        self.session.stopRunning()
        
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
        }
        
        self.sheetAlert(msgCont: stringValue)
    }
    
    private func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        self.session.stopRunning()
        
        var stringValue:String?
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
        }
        
        self.alertAction(msgCont: stringValue)
    }
    
    func sheetAlert(msgCont: String!) {
        
        let copyAction = UIAlertAction.init(title: "Copy", style: .default) {[weak self] (action: UIAlertAction) in
            UIPasteboard.general.string = msgCont
            self?.session.startRunning()
        }
        
        let openAction = UIAlertAction.init(title: "Search On Amazon", style: .default) {[weak self] (action: UIAlertAction) in
            let webVC = AMZWebViewController()
            webVC.ASINString = msgCont
            self?.navigationController?.pushViewController(webVC, animated: true)
        }
        
        let localDataAction = UIAlertAction.init(title: "Local Data", style: .default) {[weak self] (action: UIAlertAction) in
            let detailVC: AMZProductDetailViewController = AMZUtil.createStoryBoardViewController(storyBoardIdentifier: "AMZProductDetailViewController") as! AMZProductDetailViewController
            detailVC.productLabelNum = msgCont
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel) {[weak self] (action: UIAlertAction) in
            self?.session.startRunning()
        }
        
        let sheetAlert = UIAlertController.init(title: nil, message: msgCont, preferredStyle: .actionSheet)
        sheetAlert.addAction(copyAction)
        sheetAlert.addAction(openAction)
        sheetAlert.addAction(localDataAction)
        sheetAlert.addAction(cancelAction)
        
        self.present(sheetAlert, animated: true) {
            
        }
    }
    
    func alertAction(msgCont: String!) {
        
        let alAction = UIAlertAction.init(title: "sure", style: .default) { [weak self](action: UIAlertAction) in
            self?.session.startRunning()
        }
        
        
        let alertVC = UIAlertController.init(title: nil, message: msgCont, preferredStyle: .alert)
        alertVC.addAction(alAction)
        
        self.present(alertVC, animated: true) {
            
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("AMZScanViewController deinit")
    }
}

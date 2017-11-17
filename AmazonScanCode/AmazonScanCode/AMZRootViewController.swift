//
//  AMZRootViewController.swift
//  AmazonScanCode
//
//  Created by yonghao on 2017/9/8.
//  Copyright © 2017年 yonghao. All rights reserved.
//

import Foundation   
import UIKit

class AMZRootViewController: NSObject {
    
    class func createTestVC() -> UIViewController {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController")
        let nav = AMZRootViewController.createNavRootViewController(vc: vc)
        return nav
    }
    
    class func createScanNav() -> UIViewController {
        let amzScanVC = AMZScanViewController()
        let nav = AMZRootViewController.createNavRootViewController(vc: amzScanVC)
        return nav
    }
    
    class func createNavRootViewController(vc: UIViewController) -> UIViewController {
        let nav: UINavigationController = UINavigationController.init(rootViewController: vc)
        return nav
    }
}

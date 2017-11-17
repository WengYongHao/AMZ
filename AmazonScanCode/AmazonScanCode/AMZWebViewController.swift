//
//  AMZWebViewController.swift
//  AmazonScanCode
//
//  Created by yonghao on 2017/9/8.
//  Copyright © 2017年 yonghao. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class AMZWebViewController: UIViewController {

    open var ASINString: String?
    
    
    lazy var webView: WKWebView? = {
        let webV = WKWebView()
        return webV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    func setUpUI() {
        self.view.addSubview(self.webView!)
        self.webView?.frame = self.view.bounds
        let req = URLRequest.init(url: URL.init(string: "https://www.amazon.com/gp/aw/s/ref=is_s?k="+ASINString!)!)
        self.webView?.load(req)
    }
}

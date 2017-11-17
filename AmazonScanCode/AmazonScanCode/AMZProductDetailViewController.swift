//
//  AMZProductDetailViewController.swift
//  AmazonScanCode
//
//  Created by yonghao on 2017/11/16.
//  Copyright © 2017年 yonghao. All rights reserved.
//

import UIKit

class AMZProductDetailViewController: UIViewController {
    
    open var productLabelNum: String = ""
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImageView.image = UIImage(named: productLabelNum)
        
        
        let dic = self.fetchLocalProductsData() as! Dictionary<String, Any>

    }
    
    func fetchLocalProductsData() -> AnyObject {
        let path: String = Bundle.main.path(forResource: "products", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let json: AnyObject = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject
        return json
    }
}

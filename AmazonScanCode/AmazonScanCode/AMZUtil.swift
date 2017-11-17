//
//  AMZUtil.swift
//  AmazonScanCode
//
//  Created by yonghao on 2017/11/16.
//  Copyright © 2017年 yonghao. All rights reserved.
//

import UIKit

class AMZUtil: NSObject {
    
    class func createStoryBoardViewController(storyBoardIdentifier: String) -> UIViewController {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: storyBoardIdentifier)
        return vc
    }
}

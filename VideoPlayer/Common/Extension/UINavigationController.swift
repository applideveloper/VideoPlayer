//
//  UINavigationController.swift
//  VideoPlayer
//
//  Created by 荒木 敦 on 2016/12/04.
//  Copyright © 2016年 WishMatch, Inc. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    

    public override func shouldAutorotate() -> Bool {
//        let userDefaults = NSUserDefaults.standardUserDefaults()
//        
//        if let isShouldAutorotate = userDefaults.objectForKey(isShouldAutorotate) as? Bool {
//            return isShouldAutorotate
//        } else {
//            return false
//        }
        return true
    }
}

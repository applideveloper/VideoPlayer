//
//  NSObject.swift
//  VideoPlayer
//
//  Created by 荒木 敦 on 2016/12/04.
//  Copyright © 2016年 WishMatch, Inc. All rights reserved.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(self)
    }
    
    var className: String {
        return self.dynamicType.className
    }
}

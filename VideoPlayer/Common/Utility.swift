//
//  Utility.swift
//  VideoPlayer
//
//  Created by 荒木 敦 on 2016/12/04.
//  Copyright © 2016年 WishMatch, Inc. All rights reserved.
//

import Foundation

final class Utility {
    class func getSubject(title: String?) -> String? {
        if let title = title {
            if title.containsString("英語") {
                return "英語"
            } else if title.containsString("数学") {
                return "数学"
            } else if title.containsString("現代文") {
                return "現代文"
            } else if title.containsString("古文") {
                return "古文"
            } else if title.containsString("化学") {
                return "化学"
            } else if title.containsString("物理") {
                return "物理"
            } else if title.containsString("生物") {
                return "生物"
            } else if title.containsString("社会") {
                return "社会"
            } else if title.containsString("世界史") {
                return "世界史"
            } else if title.containsString("地理") {
                return "地理"
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

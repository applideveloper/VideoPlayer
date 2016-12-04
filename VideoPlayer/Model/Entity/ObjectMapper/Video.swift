//
//  VideoPlayList.swift
//  VideoPlayer
//
//  Created by 荒木 敦 on 2016/12/03.
//  Copyright © 2016年 WishMatch, Inc. All rights reserved.
//

import Foundation
import ObjectMapper

struct Video: Mappable {
    var title: String?
    var presenter_name: String?
    var description: String?
    var thumbnail_url: String?
    var video_url: String?
    var video_duration: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        presenter_name <- map["presenter_name"]
        description <- map["description"]
        thumbnail_url <- map["thumbnail_url"]
        video_url <- map["video_url"]
        video_duration <- map["video_duration"]
    }
}

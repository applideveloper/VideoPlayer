//
//  VideoPlayListFetcher.swift
//  VideoPlayer
//
//  Created by 荒木 敦 on 2016/12/03.
//  Copyright © 2016年 WishMatch, Inc. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftTask
import ObjectMapper

final class VideoPlayListFetcher: NSObject {
    
    let videoPlayListUrl = "https://gist.githubusercontent.com/sa2dai/a9c940857e37c71338dc3ae6475a2d65/raw/1902ea8074a9f4f0a2d6a12fa9698a31ba7e0c65/video_play_list.json"
    
    typealias Progress = (bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64)

    typealias AlamoFireTask = Task<Progress, [Video]?, NSError>
    
    func getResponse() -> AlamoFireTask {
        let task = AlamoFireTask { progress, fulfill, reject, configure in
            Alamofire
            .request(
                Method.GET,
                self.videoPlayListUrl,
                parameters: nil,
                encoding: ParameterEncoding.JSON,
                headers: nil
            )
            .progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                progress((bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) as Progress)
            }
            .responseArray { (response: Response<[Video], NSError>) in
                switch response.result {
                    case Result<[Video], NSError>.Success(let videoArray):
                        fulfill(videoArray)
                    case Result<[Video], NSError>.Failure(let error):
                        reject(error)
                }
            }
        }
        
        return task
    }
}

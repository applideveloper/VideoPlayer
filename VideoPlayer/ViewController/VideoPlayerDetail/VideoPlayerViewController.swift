//
//  VideoPlayerViewController.swift
//  VideoPlayer
//
//  Created by 荒木 敦 on 2016/12/04.
//  Copyright © 2016年 WishMatch, Inc. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayerViewController: AVPlayerViewController {
    var video: Video?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let video = self.video,
            let videoUrlString = video.video_url,
            let videoUrl = NSURL(string: videoUrlString)
            where videoUrlString.isEmpty == false else {
            // FIXME: error report
            let alertController = UIAlertController(
                title: "動画取得エラー",
                message: "動画が取得できませんでした",
                preferredStyle: UIAlertControllerStyle.Alert
            )
            
            let alertAction = UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Default,
                handler: { (alertAction: UIAlertAction) in
                    
                }
            )
            
            alertController.addAction(alertAction)
            
            self.presentViewController(alertController, animated: true, completion: {
                
            })
            
            self.dismissViewControllerAnimated(true, completion: {
                
            })
            return
        }
        
        print("video.title = \(video.title)")
        print("video.presenter_name = \(video.presenter_name)")
        print("video.description = \(video.description)")
        print("video.video_url = \(video.video_url)")
        
        let playerItem = AVPlayerItem(URL: videoUrl)
        
        self.player = AVPlayer(playerItem: playerItem)
        
        guard let player = self.player else {
            return
        }
        
        self.player = player
        
        print("self.view.bounds.width = \(self.view.bounds.width) self.view.bounds.height = \(self.view.bounds.height)")
        
        self.videoGravity = AVLayerVideoGravityResizeAspect
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.onUIDeviceOrientationDidChangeNotification), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Set isShouldAutorotate flag
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: isShouldAutorotate)
        
        guard let navigationController = self.navigationController else {
            return
        }
        
        navigationController.shouldAutorotate()
    }
    
    // 端末の向きがかわったら呼び出される.
    func onUIDeviceOrientationDidChangeNotification(notification: NSNotification) {
        let deviceOrientation = UIDevice.currentDevice().orientation
        
        // Set isLandscape flag
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        // 向きの判定
        if UIDeviceOrientationIsLandscape(deviceOrientation) {
            //横向きの判定.
            userDefaults.setBool(true, forKey: isLandscape)
        } else {
            //縦向きの判定.
            userDefaults.setBool(false, forKey: isLandscape)
        }
    }
}

//
//  VideoPlayerDetailViewController.swift
//  VideoPlayer
//
//  Created by 荒木 敦 on 2016/12/04.
//  Copyright © 2016年 WishMatch, Inc. All rights reserved.
//

import UIKit

import AVFoundation

class VideoPlayerDetailViewController: UIViewController {
    
    var video: Video?
    var tableView: UITableView?

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
            
            self.navigationController?.popViewControllerAnimated(true)
            return
        }
        
        self.navigationItem.title = Utility.getSubject(video.title)
        
        self.tableView = UITableView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: self.view.bounds.width,
                height: self.view.bounds.height
            )
        )
        
        guard let tableView = self.tableView else {
            return
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorColor = UIColor.clearColor()
        tableView.backgroundColor = UIColor.lightGrayColor()
        
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension VideoPlayerDetailViewController: UITableViewDelegate {

}

extension VideoPlayerDetailViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

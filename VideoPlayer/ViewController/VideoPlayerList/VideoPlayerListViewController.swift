//
//  VideoPlayerViewController.swift
//  VideoPlayer
//
//  Created by 荒木 敦 on 2016/12/03.
//  Copyright © 2016年 WishMatch, Inc. All rights reserved.
//

import UIKit
import SwiftTask

class VideoPlayerListViewController: UIViewController {
    
    var tableView: UITableView?
    
    var videoArray: [Video]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "受験サプリ"

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
        
        self.tableView?.registerNib(
            UINib(nibName: VideoPlayListTableViewCell.className, bundle: nil),
            forCellReuseIdentifier: VideoPlayListTableViewCell.className
        )
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        VideoPlayListFetcher()
        .getResponse()
        .success { (videoArray: [Video]?) -> Void in
            self.videoArray = videoArray
            self.tableView?.reloadData()
        }
        .failure { (error, isCancelled) in
            // FIXME: error report
            print("error?.description = \(error?.description)" +
                "isCancelled = \(isCancelled)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension VideoPlayerListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let videoArray = self.videoArray else {
            // FIXME: report error
            return
        }
        
        let video = videoArray[indexPath.row]
    }
}

extension VideoPlayerListViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoArray?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let videoArray = self.videoArray else {
            return ViewUtility.getCustomColorTableViewCell(color: UIColor.clearColor())
        }
        
        guard let tableView = self.tableView,
            let videoPlayListTableViewCell = tableView.dequeueReusableCellWithIdentifier(VideoPlayListTableViewCell.className) as? VideoPlayListTableViewCell else {
            return ViewUtility.getCustomColorTableViewCell(color: UIColor.clearColor())
        }
        
        let video = videoArray[indexPath.row]
        
        videoPlayListTableViewCell.thumbnailUrlString = video.thumbnail_url
        videoPlayListTableViewCell.titleLabel.text = video.title
        videoPlayListTableViewCell.presenterNameLabel.text = video.presenter_name
        videoPlayListTableViewCell.descriptionLabel.text = video.description
        videoPlayListTableViewCell.videoDuration = video.video_duration

        return videoPlayListTableViewCell
    }
}

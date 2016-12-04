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
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.onUIDeviceOrientationDidChangeNotification), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set isLandscape flag
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        // 向きの判定
        if let isLandscape = userDefaults.objectForKey(isLandscape) as? Bool
            where isLandscape == true {
            // ステータスバーの高さを取得
            let statusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
            
            // ナビゲーションバーの高さを取得
            let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
            
            //横向きの判定.
            self.tableView = UITableView(
                frame: CGRect(
                    x: 0,
                    y: statusBarHeight + navigationBarHeight,
                    width: UIScreen.mainScreen().bounds.size.width,
                    height: UIScreen.mainScreen().bounds.size.height
                )
            )
        } else {
            self.tableView = UITableView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: UIScreen.mainScreen().bounds.size.width,
                    height: UIScreen.mainScreen().bounds.size.height
                )
            )
        }
        
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
        
        tableView.registerNib(
            UINib(nibName: VideoPlayListTableViewCell.className, bundle: nil),
            forCellReuseIdentifier: VideoPlayListTableViewCell.className
        )
        
        tableView.contentOffset = CGPointMake(0, tableView.contentInset.top)
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        // Set isLandscape flag
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        // 向きの判定
        if let isLandscape = userDefaults.objectForKey(isLandscape) as? Bool
            where isLandscape == true {
            // ステータスバーの高さを取得
            let statusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
            
            // ナビゲーションバーの高さを取得
            let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
            
            //横向きの判定.
            self.tableView = UITableView(
                frame: CGRect(
                    x: 0,
                    y: statusBarHeight + navigationBarHeight,
                    width: UIScreen.mainScreen().bounds.size.width,
                    height: UIScreen.mainScreen().bounds.size.height
                )
            )
        } else {
            self.tableView = UITableView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: UIScreen.mainScreen().bounds.size.width,
                    height: UIScreen.mainScreen().bounds.size.height
                )
            )
        }
        
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
        
        tableView.registerNib(
            UINib(nibName: VideoPlayListTableViewCell.className, bundle: nil),
            forCellReuseIdentifier: VideoPlayListTableViewCell.className
        )
        
        tableView.contentOffset = CGPointMake(0, tableView.contentInset.top)
        
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
        
        self.tableView?.reloadData()
    }
}

extension VideoPlayerListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let videoArray = self.videoArray else {
            // FIXME: report error
            return
        }
        
        let video = videoArray[indexPath.row]
        
        let videoPlayerDetailViewController = VideoPlayerDetailViewController()
        videoPlayerDetailViewController.video = video
        
        let videoPlayerViewController = VideoPlayerViewController()
        videoPlayerViewController.video = video
        self.presentViewController(videoPlayerViewController, animated: true) { 
            
        }
        
//        guard let navigationController = self.navigationController,
//            let topViewController = navigationController.topViewController
//            where topViewController.className != VideoPlayerViewController.className else {
//            return
//        }
//        videoPlayerDetailViewController.video = video
//        self.navigationController?.pushViewController(videoPlayerDetailViewController, animated: true)
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
        
        // Set isLandscape flag
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        // 向きの判定
        if let isLandscape = userDefaults.objectForKey(isLandscape) as? Bool
            where isLandscape == true {
            videoPlayListTableViewCell.thumbnailImageViewHeight.constant = CGFloat(250)
        } else {
            videoPlayListTableViewCell.thumbnailImageViewHeight.constant = CGFloat(168)
        }
        
        videoPlayListTableViewCell.titleLabel.text = video.title
        videoPlayListTableViewCell.presenterNameLabel.text = video.presenter_name
        videoPlayListTableViewCell.descriptionLabel.text = video.description
        videoPlayListTableViewCell.videoDuration = video.video_duration

        return videoPlayListTableViewCell
    }
}

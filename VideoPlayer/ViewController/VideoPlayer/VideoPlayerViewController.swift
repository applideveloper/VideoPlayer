//
//  VideoPlayerViewController.swift
//  VideoPlayer
//
//  Created by 荒木 敦 on 2016/12/03.
//  Copyright © 2016年 WishMatch, Inc. All rights reserved.
//

import UIKit

class VideoPlayerViewController: UIViewController {
    
    var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension VideoPlayerViewController: UITableViewDelegate {
    
}

extension VideoPlayerViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = UITableViewCell()
        tableViewCell.textLabel?.text = "テスト"
        return tableViewCell
    }
}

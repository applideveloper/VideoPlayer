//
//  VideoTableViewCell.swift
//  VideoPlayer
//
//  Created by 荒木 敦 on 2016/12/04.
//  Copyright © 2016年 WishMatch, Inc. All rights reserved.
//

import UIKit
import Kingfisher

class VideoPlayListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var thumbnailImageViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var presenterNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var videoDuration: String?
    
    var thumbnailUrlString: String? = nil {
        didSet {
            if let thumbnailUrlString = self.thumbnailUrlString {
                self.thumbnailImageView.kf_setImageWithURL(
                    NSURL(string : thumbnailUrlString),
                    // FIXME: change no image
                    placeholderImage: nil,
                    optionsInfo: [KingfisherOptionsInfoItem.CacheMemoryOnly],
                    progressBlock: { (receivedSize, totalSize) in
                        
                    }, completionHandler: { (image, error, cacheType, imageURL) in
                    self.thumbnailImageView.image = image
                })
            } else {
                self.thumbnailImageView.hidden = true
                self.thumbnailImageViewHeight.constant = CGFloat(50)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

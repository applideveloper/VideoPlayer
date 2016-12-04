//
//  ViewUtility.swift
//  VideoPlayer
//
//  Created by 荒木 敦 on 2016/12/04.
//  Copyright © 2016年 WishMatch, Inc. All rights reserved.
//

import UIKit

final class ViewUtility: NSObject {
    class func getCustomColorTableViewCell(color color: UIColor) -> UITableViewCell {
        let tableViewCell = UITableViewCell()
        tableViewCell.backgroundColor = color
        tableViewCell.selectedBackgroundView?.backgroundColor = color
        return tableViewCell
    }
}

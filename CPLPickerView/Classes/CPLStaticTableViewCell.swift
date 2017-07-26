//
//  CPLStaticTableViewCell.swift
//  CustomList
//
//  Created by Christos Christodoulou on 14/06/2017.
//  Copyright © 2017 Christos Christodoulou. All rights reserved.
//

import UIKit

@objc

class CPLStaticTableViewCell: UITableViewCell {

    @IBOutlet weak var staticLabel: UILabel!
    @IBOutlet weak var staticImage: UIImageView!

    override func awakeFromNib() {
        staticImage.layer.cornerRadius = staticImage.frame.size.width / 2
    }
}


//
//  LeftTVCell.swift
//  QQReader
//
//  Created by huwei on 2016/12/7.
//  Copyright © 2016年 JUN. All rights reserved.
//

import UIKit

class LeftTVCell: UITableViewCell {

    @IBOutlet weak var cellIV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    //充值按钮
    @IBOutlet weak var cellBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBtn.layer.borderWidth = 1
        cellBtn.layer.borderColor = UIColor.white.cgColor
        cellBtn.layer.masksToBounds = true
        cellBtn.layer.cornerRadius = 10
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

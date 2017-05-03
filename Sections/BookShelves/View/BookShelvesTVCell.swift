//
//  BookShelvesTVCell.swift
//  QQReader
//
//  Created by huwei on 2016/12/7.
//  Copyright © 2016年 JUN. All rights reserved.
//

import UIKit

class BookShelvesTVCell: UITableViewCell {

    @IBOutlet weak var bookIV: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookProgress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

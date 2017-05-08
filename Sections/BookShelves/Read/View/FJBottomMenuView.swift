//
//  FJBottomView.swift
//  QQReader
//
//  Created by jun on 2017/5/8.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJBottomMenuView: UIView {
    @IBOutlet var contentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("FJBottomMenuView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        self.awakeFromNib()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


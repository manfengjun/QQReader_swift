//
//  FJProgressMenuView.swift
//  QQReader
//
//  Created by jun on 2017/5/12.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJProgressMenuView: UIView {
    @IBOutlet var contentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("FJProgressMenuView", owner: self, options: nil)?.first as! UIView
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
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
}

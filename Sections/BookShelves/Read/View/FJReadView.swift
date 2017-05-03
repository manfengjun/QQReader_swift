//
//  FJReadView.swift
//  QQReader
//
//  Created by jun on 2017/5/3.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJReadView: UIView {
    var content: String?
    var frameRef:CTFrame?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.textMatrix = CGAffineTransform.identity
        ctx?.translateBy(x: 0, y: self.bounds.size.height)
        ctx?.scaleBy(x: 1.0, y: -1.0)
        CTFrameDraw(frameRef!, ctx!)
    }

}

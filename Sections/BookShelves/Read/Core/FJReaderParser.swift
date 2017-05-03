//
//  FJReaderParser.swift
//  QQReader
//
//  Created by jun on 2017/5/3.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJReaderParser: NSObject {
    func parserContent(content: String, config:FJReadConfig, bounds: CGRect) -> CTFrame {
        let attributedString = NSMutableAttributedString(string: content)
        let attribute = parserAttribute(config: config)
        attributedString.setAttributes(attribute, range: NSMakeRange(0, (content as NSString).length))
        let setterRef = CTFramesetterCreateWithAttributedString(attributedString)
        let pathRef = CGPath(rect: bounds, transform: nil)
        let frameRef = CTFramesetterCreateFrame(setterRef, CFRangeMake(0, 0), pathRef, nil)
        return frameRef
    }
    func parserAttribute(config:FJReadConfig) -> [String : Any] {
        let dict = NSMutableDictionary()
        dict[NSForegroundColorAttributeName] = config.fontColor
        dict[NSFontAttributeName] = UIFont.systemFont(ofSize: config.fontSize!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = config.lineSpace!
        paragraphStyle.alignment = NSTextAlignment.justified
        dict[NSParagraphStyleAttributeName] = paragraphStyle
        return dict as! [String : Any]
    }
}

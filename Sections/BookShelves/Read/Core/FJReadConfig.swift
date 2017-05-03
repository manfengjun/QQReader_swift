//
//  FJReadConfig.swift
//  QQReader
//
//  Created by jun on 2017/5/3.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJReadConfig: NSObject,NSCoding {
    //单例
    static let shareInstance = FJReadConfig()
    var fontSize: CGFloat?
    var lineSpace: CGFloat?
    var fontColor: UIColor?
    var theme: UIColor?
    override init() {
        super.init()
        lineSpace = 10.0
        fontSize = 14.0
        fontColor = UIColor.black
        theme = UIColor.white
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(fontSize, forKey:"fontSize")
        aCoder.encode(lineSpace, forKey:"lineSpace")
        aCoder.encode(fontColor, forKey:"fontColor")
        aCoder.encode(theme, forKey:"theme")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        fontSize = aDecoder.decodeObject(forKey: "fontSize") as? CGFloat
        lineSpace = aDecoder.decodeObject(forKey: "lineSpace") as? CGFloat
        fontColor = aDecoder.decodeObject(forKey: "fontColor") as? UIColor
        theme = aDecoder.decodeObject(forKey: "theme") as? UIColor
    }
}

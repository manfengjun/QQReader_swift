//
//  BaseTheme.swift
//  HuweiBaby
//
//  Created by HW_zhangbin on 16/6/29.
//  Copyright © 2016年 huwei123. All rights reserved.
//
import UIKit
typealias block = ()->Void
//MARK ---- Public
public let ScreenWidth:CGFloat = UIScreen.main.bounds.size.width
public let ScreenHeight:CGFloat = UIScreen.main.bounds.size.height
public let ScreenBounds:CGRect = UIScreen.main.bounds
public let KeyWindow:UIWindow = UIApplication.shared.keyWindow!

public let IS_IPHONE_4:Bool = ScreenHeight < 568
public let IS_IPHONE_5:Bool = ScreenHeight == 568
public let IS_IPHONE_6:Bool = ScreenHeight == 667
public let IS_IPHONE_6P:Bool = ScreenHeight == 736

public let MAINBGCOLOR = UIColor.white
public let MAINBTCOLOR = RGBColor(66,g: 189,b: 86)
public let MAINBARCOLOR = RGBColor(66,g: 189,b: 86)
public let PLACEHOLDERCOLOR = RGBColor(161,g: 161,b: 161)

public let TopSpacing:CGFloat = 40.0
public let BottomSpacing:CGFloat = 40.0
public let LeftSpacing:CGFloat = 20.0
public let RightSpacing:CGFloat = 20.0

class BaseTheme: NSObject {

    //单例
    static let sharedInstance = BaseTheme()
}
/**
 RGB颜色
 
 - parameter r: r description
 - parameter g: g description
 - parameter b: b description
 
 - returns: return value description
 */
func RGBColor(_ r:Float,g:Float,b:Float) -> UIColor {
    return UIColor(colorLiteralRed: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}


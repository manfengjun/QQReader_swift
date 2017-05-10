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
public let MAINBTCOLOR = RGBColor(r: 66,g: 189,b: 86)
public let MAINBARCOLOR = RGBColor(r: 95,g: 164,b: 236)
public let PLACEHOLDERCOLOR = RGBColor(r: 161,g: 161,b: 161)

public let TopSpacing:CGFloat = 40.0
public let BottomSpacing:CGFloat = 40.0
public let LeftSpacing:CGFloat = 20.0
public let RightSpacing:CGFloat = 20.0

class BaseTheme: NSObject {

    //单例
    static let sharedInstance = BaseTheme()
}

/// RGB颜色
///
/// - Parameters:
///   - r: r description
///   - g: g description
///   - b: b description
/// - Returns: return value description
func RGBColor(r:Float,g:Float,b:Float) -> UIColor {
    return UIColor(colorLiteralRed: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

/// RGB颜色(透明度)
///
/// - Parameters:
///   - r: r description
///   - g: g description
///   - b: b description
///   - a: a description
/// - Returns: return value description
func RGBColor(r:Float,g:Float,b:Float,a:Float) -> UIColor {
    return UIColor(colorLiteralRed: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

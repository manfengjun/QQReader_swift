//
//  FJReadUtilites.swift
//  QQReader
//
//  Created by jun on 2017/5/3.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJReadUtilites: NSObject {
    func extractChapterListWithContent(content: String) -> NSMutableArray {
        let regPattern = "(\\s)+[第]{0,1}[0-9一二三四五六七八九十百千万]+[章回节卷集幕计][ \t]*(\\S)*"
        var regExp: NSRegularExpression?
        do {
            regExp = try NSRegularExpression(pattern: regPattern, options: NSRegularExpression.Options.caseInsensitive)
        } catch { }
        return regExp!.matches(in: content, options: NSRegularExpression.MatchingOptions.reportCompletion , range: NSMakeRange(0, (content as NSString).length)) as! NSMutableArray
    }
}

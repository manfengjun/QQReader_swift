//
//  FJReadUtilites.swift
//  QQReader
//
//  Created by jun on 2017/5/3.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJReadUtilites: NSObject {
    // MARK: ------ 筛选目录
    class func separateChapter(content: String) -> NSMutableArray{
        let contentStr = NSString(string: content)
        let chapterModels = NSMutableArray()
        //筛选目录
        let regPattern = "(\\s)+[第]{0,1}[0-9一二三四五六七八九十百千万]+[章回节卷集幕计][ \t]*(\\S)*"
        var regExp: NSRegularExpression?
        do {
            regExp = try NSRegularExpression(pattern: regPattern, options: NSRegularExpression.Options.caseInsensitive)
        } catch {}
        let matchs = regExp!.matches(in: content, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, (content as NSString).length))
        if matchs.count != 0 {
            var lastRange = NSMakeRange(0, 0)
            for (index, value) in matchs.enumerated() {
                let range = value.range
                let local = range.location
                if index == 0 {
                    //第一章
                    let len = local
                    let title = "开始"
                    let content = contentStr.substring(with: NSMakeRange(0, len))
                    let model = FJChapterModel(title: title, content: content)
                    chapterModels.add(model)
                }
                else if index == matchs.count - 1 {
                    //获取章节内容和标题
                    let title = contentStr.substring(with: range)
                    let content = contentStr.substring(with: NSMakeRange(local, contentStr.length - local))
                    let model = FJChapterModel(title: title, content: content)
                    chapterModels.add(model)
                }
                else {
                    //获取最后一章
                    let title = contentStr.substring(with: range)
                    let len = local - lastRange.location
                    let content = contentStr.substring(with: NSMakeRange(lastRange.location, len))
                    let model = FJChapterModel(title: title, content: content)
                    chapterModels.add(model)
                }
                lastRange = range
            }
        }
        else{
            //未检测到目录
            let model = FJChapterModel()
            model.content = content
            chapterModels.add(model)
        }
        return chapterModels
    }
    // MARK: ------ 获取Txt文件内容
    class func encode(url:String) -> String {
        let fileUrl = Bundle.main.path(forResource: url, ofType: "txt")
        var bookStr: String?
        do {
            //中文编码
            let enc = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
            bookStr = try String(contentsOfFile: fileUrl!, encoding: String.Encoding(rawValue: enc))
        } catch{}
        if bookStr == nil {
            do {
                //utf8编码
                bookStr = try String(contentsOfFile: fileUrl!, encoding: String.Encoding.utf8)
            } catch{}
        }
        return bookStr!
    }
}

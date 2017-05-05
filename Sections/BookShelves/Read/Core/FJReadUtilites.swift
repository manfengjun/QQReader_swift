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

//        第[0-9一二三四五六七八九十百千]*[章回].*
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
                    let model = FJChapterModel()

                    let len = local
                    model.title = "开始"
                    model.content = contentStr.substring(with: NSMakeRange(0, len))
                    chapterModels.add(model)
                }
                else if index > 0{
                    //获取章节内容和标题
                    let model = FJChapterModel()
                    model.title = contentStr.substring(with: lastRange)
                    let len = local - lastRange.location
                    model.content = contentStr.substring(with: NSMakeRange(lastRange.location, len))
                    chapterModels.add(model)
                }
                else if index == matchs.count - 1 {
                    //获取最后一章
                    let model = FJChapterModel()
                    
                    model.title = contentStr.substring(with: range)
                    model.content = contentStr.substring(with: NSMakeRange(local, contentStr.length - local))
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
        var bookStr: String?
        do {
            //中文编码
            let enc = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
            bookStr = try String(contentsOfFile: url, encoding: String.Encoding(rawValue: enc))
        } catch{}
        if bookStr == nil {
            do {
                //utf8编码
                bookStr = try String(contentsOfFile: url, encoding: String.Encoding.utf8)
            } catch{}
        }
        return bookStr!
    }
}

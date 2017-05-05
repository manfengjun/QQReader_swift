
//
//  FJChapterModel.swift
//  QQReader
//
//  Created by jun on 2017/5/3.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJChapterModel: NSObject,NSCoding {
    lazy var pageArray:NSMutableArray = {
        let pageArray = NSMutableArray()
        return pageArray
    }()
    var content: String?{
        willSet {
            paginateWithBounds(bounds: CGRect(x: LeftSpacing, y: TopSpacing, width: ScreenWidth - LeftSpacing - RightSpacing, height: ScreenHeight - TopSpacing - BottomSpacing))
        }
    }
    var title: String?
    var chapterIndex: Int?
    var pageCount: Int?
    
    override init() {
        chapterIndex = 0
        pageCount = 0
        title = ""
        content = ""
        super.init()
    }
    // MARK: ------ 更新字体
    func updateFont() {
        paginateWithBounds(bounds: CGRect(x: LeftSpacing, y: TopSpacing, width: ScreenWidth - LeftSpacing - RightSpacing, height: ScreenHeight - TopSpacing - BottomSpacing))
    }
    // MARK: ------ 更新阅读视图显示区域位置
    func paginateWithBounds(bounds:CGRect) {
        pageArray.removeAllObjects()
        let attrString = NSMutableAttributedString(string: content!)
        let attribute = FJReaderParser().parserAttribute(config: FJReadConfig.shareInstance)
        attrString.setAttributes(attribute, range: NSMakeRange(0, attrString.length))
        let frameSetter = CTFramesetterCreateWithAttributedString(attrString)
        let path = CGPath(rect: bounds, transform: nil)
        var currentOffset = 0
        var currentInnerOffset = 0
        var hasMorePages = true
        let preventDeadLoopSign = currentOffset
        var samePlaceRepeatCount = 0
        
        while hasMorePages {
            if preventDeadLoopSign == currentOffset {
                samePlaceRepeatCount += 1
            }
            else
            {
                samePlaceRepeatCount = 0
            }
            if samePlaceRepeatCount > 1 {
                if pageArray.count == 0 {
                    pageArray.add(currentOffset)
                }
                else
                {
                    let lastOffset = pageArray.lastObject
                    if lastOffset as! Int != currentOffset {
                        pageArray.add(currentOffset)
                    }
                }
                break
            }
            pageArray.add(currentOffset)
            let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(currentInnerOffset, 0), path, nil)
            let range = CTFrameGetVisibleStringRange(frame)
            if range.location + range.length != attrString.length {
                currentOffset += range.length
                currentInnerOffset += range.length
            }
            else
            {
                hasMorePages = false
            }
        }
        pageCount = pageArray.count
    }
    // MARK: ------ 获取当前页面文字内容
    func stringOfPage(index: Int) -> String {
        let local = pageArray[index] as! Int
        var length: Int = 0
        if index < pageCount! - 1 {
            length = (pageArray[index + 1] as! Int) - (pageArray[index] as! Int)
        }
        else {
            length = (content! as NSString).length - (pageArray[index] as! Int)
        }
        
        let nscontent = NSString(string: content!)
        return nscontent.substring(with: NSMakeRange(local, length))
    }
    
    // MARK: ------ 归档反归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(pageArray, forKey:"pageArray")
        aCoder.encode(content, forKey:"content")
        aCoder.encode(title, forKey:"title")
        aCoder.encode(chapterIndex, forKey:"chapterIndex")
        aCoder.encode(pageCount, forKey:"pageCount")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        pageArray = (aDecoder.decodeObject(forKey: "pageArray") as? NSMutableArray)!
        content = aDecoder.decodeObject(forKey: "content") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        chapterIndex = aDecoder.decodeObject(forKey: "chapterIndex") as? Int
        pageCount = aDecoder.decodeObject(forKey: "pageCount") as? Int
    }
}

//
//  FJRecordModel.swift
//  QQReader
//
//  Created by jun on 2017/5/3.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJRecordModel: NSObject,NSCoding {
    //页数
    var page: Int?
    //章节数
    var chapter: Int?
    //总章节数
    var chapterCount: Int?
    //阅读章节
    var chapterModel: FJChapterModel?
    override init() {
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(page, forKey:"page")
        aCoder.encode(chapter, forKey:"chapter")
        aCoder.encode(chapterCount, forKey:"chapterCount")
        aCoder.encode(chapterModel, forKey:"chapterModel")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        page = aDecoder.decodeObject(forKey: "page") as? Int
        chapter = aDecoder.decodeObject(forKey: "chapter") as? Int
        chapterCount = aDecoder.decodeObject(forKey: "chapterCount") as? Int
        chapterModel = aDecoder.decodeObject(forKey: "chapterModel") as? FJChapterModel
    }
}


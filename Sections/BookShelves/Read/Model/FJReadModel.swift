//
//  FJReadModel.swift
//  QQReader
//
//  Created by jun on 2017/5/3.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJReadModel: NSObject {
    var resource: URL?
    var content: String?
    var fjMarkModels: NSMutableArray?
    var fjNoteModels: NSMutableArray?
    var fjChapterModels: NSMutableArray?
    var marksRecord: NSMutableDictionary?
    var record: FJRecordModel?
    var font: CGFloat?
    init(content: String) {
        super.init()
        self.content = content
        self.fjChapterModels = NSMutableArray()
        self.fjMarkModels = NSMutableArray()
        self.fjNoteModels = NSMutableArray()
        self.record = FJRecordModel()
        self.record?.chapterModel = fjChapterModels?.firstObject as? FJChapterModel
        self.record?.chapterCount = fjChapterModels?.count
        self.marksRecord = NSMutableDictionary()
        self.font = FJReadConfig.shareInstance.fontSize
        
    }
    init(epub: String) {
        super.init()
        self.fjChapterModels = NSMutableArray()
        self.fjMarkModels = NSMutableArray()
        self.fjNoteModels = NSMutableArray()
        self.record = FJRecordModel()
        self.record?.chapterModel = fjChapterModels?.firstObject as? FJChapterModel
        self.record?.chapterCount = fjChapterModels?.count
        self.marksRecord = NSMutableDictionary()
        self.font = FJReadConfig.shareInstance.fontSize

    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(resource, forKey:"resource")
        aCoder.encode(content, forKey:"content")
        aCoder.encode(fjMarkModels, forKey:"fjMarkModels")
        aCoder.encode(fjNoteModels, forKey:"fjNoteModels")
        aCoder.encode(fjChapterModels, forKey:"fjChapterModels")
        aCoder.encode(marksRecord, forKey:"marksRecord")
        aCoder.encode(record, forKey:"record")
        aCoder.encode(font, forKey:"font")

    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        resource = aDecoder.decodeObject(forKey: "resource") as? URL
        content = aDecoder.decodeObject(forKey: "content") as? String
        fjMarkModels = aDecoder.decodeObject(forKey: "fjMarkModels") as? NSMutableArray
        fjNoteModels = aDecoder.decodeObject(forKey: "fjNoteModels") as? NSMutableArray
        fjChapterModels = aDecoder.decodeObject(forKey: "fjChapterModels") as? NSMutableArray
        marksRecord = aDecoder.decodeObject(forKey: "marksRecord") as? NSMutableDictionary
        record = aDecoder.decodeObject(forKey: "record") as? FJRecordModel
        font = aDecoder.decodeObject(forKey: "font") as? CGFloat
    }
//    func getPathIndexByOffset(offset: Int, chapterIndex: Int) -> Int {
//        
//    }
    func updateLocalModel(readModel: FJReadModel, url: URL) {
        
    }
    func getLocalModel(url: URL) {
        
    }
}

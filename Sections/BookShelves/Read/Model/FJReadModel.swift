//
//  FJReadModel.swift
//  QQReader
//
//  Created by jun on 2017/5/3.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJReadModel: NSObject,NSCoding {
    //地址
    var resource: String?
    //小说名字
    var title: String?
    //小说内容
    var content: String?
//    //
//    var fjMarkModels: NSMutableArray?
//    //
//    var fjNoteModels: NSMutableArray?
    //章节
    var fjChapterModels: NSMutableArray?
    //
//    var marksRecord: NSMutableDictionary?
    //
    var record: FJRecordModel?
    //字体
    var font: CGFloat?
    override init() {
        super.init()
    }
    init(content: String) {
        self.content = content
        self.fjChapterModels = FJReadUtilites.separateChapter(content: content)
//        self.fjMarkModels = NSMutableArray()
//        self.fjNoteModels = NSMutableArray()
        self.record = FJRecordModel()
        self.record?.chapterModel = fjChapterModels?.firstObject as? FJChapterModel
        self.record?.chapterCount = (fjChapterModels?.count)!
//        self.marksRecord = NSMutableDictionary()
        self.font = FJReadConfig.shareInstance.fontSize
    }
    init(epub: String) {
        self.fjChapterModels = NSMutableArray()
//        self.fjMarkModels = NSMutableArray()
//        self.fjNoteModels = NSMutableArray()
        self.record = FJRecordModel()
        self.record?.chapterModel = fjChapterModels?.firstObject as? FJChapterModel
        self.record?.chapterCount = (fjChapterModels?.count)!
//        self.marksRecord = NSMutableDictionary()
        self.font = FJReadConfig.shareInstance.fontSize

    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(resource, forKey:"resource")
        aCoder.encode(content, forKey:"content")
//        aCoder.encode(fjMarkModels, forKey:"fjMarkModels")
//        aCoder.encode(fjNoteModels, forKey:"fjNoteModels")
        aCoder.encode(fjChapterModels, forKey:"fjChapterModels")
//        aCoder.encode(marksRecord, forKey:"marksRecord")
        aCoder.encode(record, forKey:"record")
        aCoder.encode(font, forKey:"font")

    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        resource = aDecoder.decodeObject(forKey: "resource") as? String
        content = aDecoder.decodeObject(forKey: "content") as? String
//        fjMarkModels = aDecoder.decodeObject(forKey: "fjMarkModels") as? NSMutableArray
//        fjNoteModels = aDecoder.decodeObject(forKey: "fjNoteModels") as? NSMutableArray
        fjChapterModels = aDecoder.decodeObject(forKey: "fjChapterModels") as? NSMutableArray
//        marksRecord = aDecoder.decodeObject(forKey: "marksRecord") as? NSMutableDictionary
        record = aDecoder.decodeObject(forKey: "record") as? FJRecordModel
        font = aDecoder.decodeObject(forKey: "font") as? CGFloat
    }
    // MARK: ------ 获取页数偏移量
    func getPageIndex(offset:Int, chapterIndex:Int) -> Int {
        let model = fjChapterModels?[chapterIndex] as! FJChapterModel
        let pageArray = model.pageArray
        for (index, value) in pageArray.enumerated() {
            if offset >= value as! Int && offset < pageArray[index + 1] as! Int {
                return index
            }
        }
        if offset >= pageArray[pageArray.count - 1] as! Int {
            return pageArray.count - 1
        }
        else
        {
            return 0
        }
    }
    // MARK: ------ 更新本地缓存
    class func updateLocalModel(readModel: FJReadModel, url: String) {
        let key = NSString(string: url).lastPathComponent
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(readModel, forKey: key)
        archiver.finishEncoding()
        UserDefaults.standard.setValue(data, forKey: key)
    }
    // MARK: ------ 获取本地缓存
    class func getLocalModel(url: String) -> FJReadModel{
        let key = NSString(string: url).lastPathComponent
        let data = UserDefaults.standard.object(forKey: key)
        let title = NSString(string: key)
        if data == nil{
            if key.hasSuffix("txt"){
                let model = FJReadModel(content: FJReadUtilites.encode(url: url))
                model.resource = url
                FJReadModel.updateLocalModel(readModel: model, url: url)
                return model
            }
            else if key.hasSuffix("epub"){
                
            }
            else{
                print("异常")
            }

        }
        let unarchive = NSKeyedUnarchiver(forReadingWith: data as! Data)
        let model = unarchive.decodeObject(forKey: key) as! FJReadModel
        if model.font != FJReadConfig.shareInstance.fontSize {
            let model = FJReadModel(content: FJReadUtilites.encode(url: url))
            model.resource = url
            FJReadModel.updateLocalModel(readModel: model, url: url)
            return model
        }
        model.title = title.substring(to: title.length - 4)
        return model
    }
    
}

//
//  FJMarkModel.swift
//  QQReader
//
//  Created by jun on 2017/5/3.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJMarkModel: NSObject {
    var date: Date?
    var location: Int?
    var length: Int?
    var chapter: Int?
    var recordModel: FJRecordModel?
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey:"date")
        aCoder.encode(location, forKey:"location")
        aCoder.encode(length, forKey:"length")
        aCoder.encode(chapter, forKey:"chapter")
        aCoder.encode(recordModel, forKey:"recordModel")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        date = aDecoder.decodeObject(forKey: "date") as? Date
        location = aDecoder.decodeObject(forKey: "location") as? Int
        length = aDecoder.decodeObject(forKey: "length") as? Int
        chapter = aDecoder.decodeObject(forKey: "chapter") as? Int
        recordModel = aDecoder.decodeObject(forKey: "recordModel") as? FJRecordModel
    }
}

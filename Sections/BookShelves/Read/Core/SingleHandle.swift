//
//  SingleHandle.swift
//  QQReader
//
//  Created by jun on 2017/5/12.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class SingleHandle: NSObject {
    //单例
    static let shareInstance = SingleHandle()
    var readModel: FJReadModel?
}

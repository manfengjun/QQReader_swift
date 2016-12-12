//
//  NSobjectExtension.swift
//  QQReader
//
//  Created by huwei on 2016/12/7.
//  Copyright © 2016年 JUN. All rights reserved.
//

import UIKit
extension NSObject
{
    /*!
     UITableViewCell 分割线
     */
    func createSeperatorLine(start:CGPoint,end:CGPoint) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        path.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = Color(238, g: 238, b: 238).cgColor
        shapeLayer.lineWidth = 0.1
        shapeLayer.path = path.cgPath
        return shapeLayer
    }
}
class NSobjectExtension: NSObject {

}

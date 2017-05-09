//
//  FJBottomView.swift
//  QQReader
//
//  Created by jun on 2017/5/8.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
class FJBottomMenuView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet var catalogTapGue: UITapGestureRecognizer!
    @IBOutlet var pregressTapGue: UITapGestureRecognizer!
    @IBOutlet var settingTapGue: UITapGestureRecognizer!
    var completionSignal:Signal<Int, NoError>?
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("FJBottomMenuView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        self.awakeFromNib()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let catalogSignal = catalogTapGue.reactive.stateChanged.map { (guesture) -> Int in
            return 1
        }
        let progressSignal = pregressTapGue.reactive.stateChanged.map { (guesture) -> Int in
            return 2
        }
        let settingSignal = settingTapGue.reactive.stateChanged.map { (guesture) -> Int in
            return 3
        }
        completionSignal = Signal.merge([catalogSignal,progressSignal,settingSignal])
        
    }
    @IBAction func ceshi(_ sender: UITapGestureRecognizer) {
        print("sdfsdfsdf")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


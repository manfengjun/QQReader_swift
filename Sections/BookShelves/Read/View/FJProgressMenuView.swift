//
//  FJProgressMenuView.swift
//  QQReader
//
//  Created by jun on 2017/5/12.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
class FJProgressMenuView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var bookSlider: UISlider!
    @IBOutlet weak var subtractBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet var hideTap: UITapGestureRecognizer!
    var completionSignal:Signal<Int, NoError>?
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("FJProgressMenuView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        self.awakeFromNib()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        bookSlider.setThumbImage(UIImage(named: "read_track.png"), for: UIControlState.normal)
        let hideSignal = hideTap.reactive.stateChanged.map { (guesture) -> Int in
            return 1
        }
        let subtractSignal = subtractBtn.reactive.controlEvents(UIControlEvents.touchUpInside).map { (button) -> Int in
            return 2
        }
        let addSignal = addBtn.reactive.controlEvents(UIControlEvents.touchUpInside).map { (button) -> Int in
            return 3
        }
        completionSignal = Signal.merge([hideSignal,subtractSignal,addSignal])

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
}

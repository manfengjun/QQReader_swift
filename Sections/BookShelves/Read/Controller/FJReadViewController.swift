
//
//  FJReadViewController.swift
//  QQReader
//
//  Created by jun on 2017/5/3.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJReadViewController: UIViewController {
    var content: String?
    lazy var readView:FJReadView = {
        let readView = FJReadView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        let config = FJReadConfig.shareInstance
        readView.frameRef = FJReaderParser().parserContent(content: self.content!, config: config, bounds: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        readView.content = self.content!
        return readView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(readView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

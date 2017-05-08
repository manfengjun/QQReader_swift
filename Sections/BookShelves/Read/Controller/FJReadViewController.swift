
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
    var recordModel: FJRecordModel?
    lazy var readView:FJReadView = {
        let readView = FJReadView(frame: CGRect(x: LeftSpacing, y: TopSpacing, width: self.view.frame.size.width-LeftSpacing-RightSpacing, height: self.view.frame.size.height-TopSpacing-BottomSpacing))
        let config = FJReadConfig.shareInstance
        readView.frameRef = FJReaderParser().parserContent(content: self.content!, config: config, bounds: CGRect(x: 0, y: 0, width: readView.frame.size.width, height: readView.frame.size.height))
        readView.content = self.content!
        return readView
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
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

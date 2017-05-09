//
//  FJCatalogViewController.swift
//  QQReader
//
//  Created by jun on 2017/5/9.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import HMSegmentedControl
class FJCatalogViewController: UIViewController {
    lazy var segmentControl:HMSegmentedControl = {
        let segmentControl = HMSegmentedControl(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40))
        segmentControl.sectionTitles = ["目录","书签","笔记"]
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = UIColor.white
        segmentControl.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.gray,NSFontAttributeName:UIFont.systemFont(ofSize: 14)]
        segmentControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName:UIColor.red,NSFontAttributeName:UIFont.systemFont(ofSize: 14)]
        segmentControl.selectionIndicatorColor = UIColor.red
        segmentControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.down
        segmentControl.selectionIndicatorHeight = 2
        return segmentControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(segmentControl)
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

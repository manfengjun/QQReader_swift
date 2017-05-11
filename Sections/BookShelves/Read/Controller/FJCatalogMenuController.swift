//
//  FJCatalogViewController.swift
//  QQReader
//
//  Created by jun on 2017/5/9.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import HMSegmentedControl
class FJCatalogMenuController: BaseViewController{
    @IBOutlet weak var segmentControl: HMSegmentedControl!
    @IBOutlet weak var scrollContentView: UIView!
    lazy var chapterModels:NSMutableArray = {
        let chapterModels = NSMutableArray()
        return chapterModels
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingSegment()
        setupChildControllers()
        setBackButtonInNav(imageUrl: "nav_back_white.png", action: #selector(FJReadPageViewController.dismissvc))
    }
    func settingSegment() {
        segmentControl.sectionTitles = ["目录","书签","笔记"]
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = UIColor.white
        segmentControl.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.gray,NSFontAttributeName:UIFont.systemFont(ofSize: 14)]
        segmentControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName:MAINBARCOLOR,NSFontAttributeName:UIFont.systemFont(ofSize: 14)]
        segmentControl.selectionIndicatorColor = MAINBARCOLOR
        segmentControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.down
        segmentControl.selectionIndicatorHeight = 2
        segmentControl.indexChangeBlock = {(index) in
            print(index)
        }
    }
    func setupChildControllers() {
        let stotyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let catalogListVC = stotyboard.instantiateViewController(withIdentifier: "FJCatalogListVC") as! FJCatalogListViewController
        catalogListVC.chapterModels = chapterModels
        catalogListVC.view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 104 - 64)
        self.scrollContentView.addSubview(catalogListVC.view)
        self.addChildViewController(catalogListVC)
    }
    // MARK: ------ 返回
    override func dismissvc() {
        if (dismissFunc != nil) {
            dismissFunc!()
        }
        self.navigationController?.popViewController(animated: true)
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

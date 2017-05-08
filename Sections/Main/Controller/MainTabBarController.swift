//
//  MainTabBarController.swift
//  QQReader
//
//  Created by huwei on 2016/12/7.
//  Copyright © 2016年 JUN. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 0
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    override var childViewControllerForStatusBarStyle: UIViewController?{
        return self.selectedViewController
    }
    override var childViewControllerForStatusBarHidden: UIViewController?{
        return self.selectedViewController
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

//
//  BaseNavController.swift
//  QQReader
//
//  Created by jun on 2017/5/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class BaseNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 17), NSForegroundColorAttributeName:UIColor.white]
        // Do any additional setup after loading the view.
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController?{
        return self.topViewController
    }
    
    override var childViewControllerForStatusBarHidden: UIViewController?{
        return self.topViewController
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

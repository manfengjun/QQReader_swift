//
//  BasePageViewController.swift
//  QQReader
//
//  Created by jun on 2017/5/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class BasePageViewController: UIPageViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.parent?.navigationController?.setNavigationBarHidden(false, animated: false)
        self.parent?.navigationController?.navigationBar.barTintColor = MAINBARCOLOR
        self.parent?.navigationController?.navigationBar.subviews[0].alpha = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

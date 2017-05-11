//
//  BaseViewController.swift
//  QQReader
//
//  Created by jun on 2017/5/8.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var dismissFunc:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func dismissvc() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
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

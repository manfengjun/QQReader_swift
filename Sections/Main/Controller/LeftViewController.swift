//
//  LeftViewController.swift
//  QQReader
//
//  Created by huwei on 2016/12/7.
//  Copyright © 2016年 JUN. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headIV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var recentlyReadLabel: UILabel!
    @IBOutlet weak var promtView: UIView!
    
    lazy var titleArr:NSMutableArray = {
        ["我的账户","我的包月","我的消息","浏览历史","影视原著"]
    }()
    lazy var titleImgArr:NSMutableArray = {
        ["left_zhanghu.png","left_baoyue.png","left_xiaoxi.png","left_lishi.png","left_liwu.png"]
    }()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //初始化
        self.commoninit()

        // Do any additional setup after loading the view.
    }
    func commoninit() {
        headIV.layer.masksToBounds = true
        headIV.layer.cornerRadius = 25
        promtView.layer.masksToBounds = true
        promtView.layer.cornerRadius = 25/2
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
extension LeftViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leftTVCell", for: indexPath) as! LeftTVCell
        let lineLayer = self.createSeperatorLine(start: CGPoint(x: 15, y: 49),end:CGPoint(x: ScreenWidth - 15, y: 49))
        if indexPath.row%2 != 0 {
            cell.layer.addSublayer(lineLayer)
        }
        cell.cellBtn.isHidden = true
        if indexPath.row == 0 || indexPath.row == 1 {
            cell.cellBtn.isHidden = false
        }
        cell.titleLabel.textColor = UIColor.white
        cell.titleLabel.text = titleArr[indexPath.row] as? String
        cell.cellIV.image = UIImage(named: (titleImgArr[indexPath.row] as! String))
        if indexPath.row == 4 {
            cell.titleLabel.textColor = Color(234, g: 149, b: 24)
        }
        //#ea9518
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

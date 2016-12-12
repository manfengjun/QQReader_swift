//
//  BookShelvesViewController.swift
//  QQReader
//
//  Created by huwei on 2016/12/7.
//  Copyright © 2016年 JUN. All rights reserved.
//

import UIKit

class BookShelvesViewController: UIViewController {

    @IBOutlet var headView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var last:CGFloat?
    lazy var refreshBgView:UIView = {
        let refreshBgView = UIView(frame: CGRect(x: 0, y: -UIScreen.main.bounds.size.width*1.5, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width*1.5))
        refreshBgView.backgroundColor = UIColor(patternImage: UIImage(named:"feedflow_refresh_bg.png")!)
        return refreshBgView
    }()
    lazy var headBtn:UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        button.backgroundColor = UIColor.red
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 17;
        return button
    }()
    func refreshData() {
        let header = MJRefreshDiyHeader { 
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.tableView.mj_header.endRefreshing()
            }
        }
        header?.stateLabel.isHidden = true
        header?.lastUpdatedTimeLabel.isHidden = true
        self.tableView.mj_header = header
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        last = 0
        self.refreshData()
        self.tableView.mj_header.beginRefreshing()
        self.tableView.tableHeaderView = headView

        // Do any additional setup after loading the view.
    }
    func createNavItem() {
        let leftItem = UIBarButtonItem(customView: headBtn)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.insertSubview(self.refreshBgView, belowSubview: self.tableView)

        createNavItem()

        self.navigationController?.navigationBar.isTranslucent = true;
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.subviews[0].alpha = 0
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
extension BookShelvesViewController:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookShelvesTVCell", for: indexPath) as! BookShelvesTVCell
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var frame = self.refreshBgView.frame
        frame.origin.y = frame.origin.y - (scrollView.contentOffset.y - last!)
        self.refreshBgView.frame = frame
        last = scrollView.contentOffset.y
        self.view.setNeedsLayout()
        if scrollView.contentOffset.y < 0 {
            self.navigationController?.navigationBar.alpha = 0
        }
        else
        {
            self.navigationController?.navigationBar.alpha = 1
            
        }
        let progress = scrollView.contentOffset.y/200
        self.navigationController?.navigationBar.subviews[0].alpha = progress
    }
}

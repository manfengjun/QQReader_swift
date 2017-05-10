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
    @IBOutlet weak var textfields: UITextField!
    var last:CGFloat?
    ///本地书籍
    lazy var booksArray:NSMutableArray = {
        let booksArray = NSMutableArray()
        return booksArray
    }()
    ///刷新背景
    lazy var refreshBgView:UIView = {
        let refreshBgView = UIView(frame: CGRect(x: 0, y: -UIScreen.main.bounds.size.width*1.5, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width*1.5))
        refreshBgView.backgroundColor = UIColor(patternImage: UIImage(named:"feedflow_refresh_bg.png")!)
        return refreshBgView
    }()
    ///头部按钮
    lazy var headBtn:UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        button.setImage(UIImage.init(named: "head.jpg"), for: UIControlState.normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 17
        button.addTarget(self, action: #selector(showLeftDraw), for: UIControlEvents.touchUpInside)
        return button
    }()
    func showLeftDraw(sender: UIButton) {
        print("sdfds")
        zjdrawerVC?.slidingLeftDrawer()
    }
    /// 刷新数据
    func refreshData() {
        let header = MJRefreshDiyHeader {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.booksArray.removeAllObjects()

                self.getBooksUrl()
                //刷新
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
            }
        }
        header?.stateLabel.isHidden = true
        header?.lastUpdatedTimeLabel.isHidden = true
        self.tableView.mj_header = header
    }
    
    /// 获取本地书籍地址
    func getBooksUrl() {
        let path = Bundle.main.bundlePath
        let fileManager = FileManager.default
        let fileArray = fileManager.subpaths(atPath: path)
//        if let array = fileArray {
            for fb in fileArray! {
                if fb.hasSuffix(".txt") {
                    let index = fb.index(fb.endIndex, offsetBy: -4)
                    self.booksArray.add(fb.substring(to: index))
                    print(fb)
                }
            }
//        }
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
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = MAINBARCOLOR
        self.navigationController?.navigationBar.subviews[0].alpha = 0
    }
    override var prefersStatusBarHidden: Bool{
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.default
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.tableView.mj_header.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "readerSegueID"{
            let indexPath = sender as! NSIndexPath
            let readVC = segue.destination as? FJReadPageViewController
            let fileUrl = Bundle.main.path(forResource: self.booksArray[indexPath.row] as? String, ofType: "txt")
            if let url = fileUrl {
                readVC?.readModel = FJReadModel.getLocalModel(url: url)
                readVC?.resourceURL = url
            }
        }
    }

}
extension BookShelvesViewController:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.booksArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookShelvesTVCell", for: indexPath) as! BookShelvesTVCell
        cell.bookTitle.text = self.booksArray[indexPath.row] as? String
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "readerSegueID", sender: indexPath)
    }
}

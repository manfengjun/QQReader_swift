//
//  FJCatalogViewController.swift
//  QQReader
//
//  Created by jun on 2017/5/11.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result
import ReactiveSwift
class FJCatalogListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
//    let (completionAignal, observer) = Signal<Any, NoError>.pipe()
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 104, right: 0)
        self.automaticallyAdjustsScrollViewInsets = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 104)
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
extension FJCatalogListViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (SingleHandle.shareInstance.readModel?.fjChapterModels?.count)!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fjCatalogListTVCell", for: indexPath) as! FJCatalogListTVCell
        let model = SingleHandle.shareInstance.readModel?.fjChapterModels?[indexPath.row] as! FJChapterModel
        cell.catalogTitle.text = model.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic = ["chapter": indexPath.row,"page":0]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectCatalog"), object: nil, userInfo: dic)
        (self.parent as! FJCatalogMenuController).dismissvc()
        
    }
}

//
//  FJCatalogViewController.swift
//  QQReader
//
//  Created by jun on 2017/5/11.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJCatalogListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var chapterModels:NSMutableArray = {
        let chapterModels = NSMutableArray()
        return chapterModels
    }()
    
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
extension FJCatalogListViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapterModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fjCatalogListTVCell", for: indexPath) as! FJCatalogListTVCell
        cell.catalogTitle.text = String(indexPath.row)
        return cell
    }
}

//
//  ReadViewController.swift
//  QQReader
//
//  Created by jun on 2017/5/2.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
class FJReadPageViewController: UIViewController {
    var chapter: Int?                       //当前显示的章节
    var page: Int?                          //当前显示的页数
    var chapterChange: Int?                 //将要变化的章节
    var pageChange: Int?                    //将要变化的页数
    var isTransition: Bool?                 //是否开始翻页
    var resourceURL: String?
    var readVC: FJReadViewController?       //当前阅读视图
    var readModel: FJReadModel?             //阅读对象
    ///翻页控制器
    lazy var pageController:UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.pageCurl, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: nil)
        pageController.delegate = self
        pageController.dataSource = self
        return pageController
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加阅读控制视图
        view.addSubview(pageController.view)
        addChildViewController(pageController)
        //设置第一页
        pageController.setViewControllers([self.readVC(chapter: 1, page: 1)], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        //初始化属性
        chapter = readModel?.record?.chapter
        page = readModel?.record?.page
        
        view.backgroundColor = UIColor.white
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
extension FJReadPageViewController: UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    // MARK: ------ UIPageViewController DataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return readVC(chapter: 1, page: 1)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return readVC(chapter: 1, page: 1)

    }
    // MARK: ------ UIPageViewController Delegate
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
    }
    func readVC(chapter: Int, page: Int) -> FJReadViewController {
        readVC = FJReadViewController()
        readVC?.content = "sdfsdfsdfdsfdsf"
        return readVC!
    }
}

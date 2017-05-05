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
        UIApplication.shared.isStatusBarHidden = true

        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        UIApplication.shared.isStatusBarHidden = false
        
        self.navigationController?.navigationBar.isHidden = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加阅读控制视图
        view.addSubview(pageController.view)
        addChildViewController(pageController)
        //设置第一页
        pageController.setViewControllers([self.readVC(chapter: (readModel?.record?.chapter)!, page: (readModel?.record?.chapter)!)], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        //初始化属性
        chapter = readModel?.record?.chapter
        page = readModel?.record?.page
        
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageController.view.frame = self.view.frame
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
    // MARK: ------ 向前翻页
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        pageChange = page
        chapterChange = chapter
        if chapterChange == 0 && pageChange == 0 {
            return nil
        }
        if pageChange == 0 {
            chapterChange! -= 1
            pageChange = (readModel?.fjChapterModels?[chapterChange!] as! FJChapterModel).pageCount! - 1
        }
        else
        {
            pageChange! -= 1
        }

        return readVC(chapter: chapterChange!, page: pageChange!)
    }
    // MARK: ------ 向后翻页
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        pageChange = page
        chapterChange = chapter
        if pageChange == (readModel?.fjChapterModels?.lastObject as! FJChapterModel).pageCount! - 1 && chapterChange! == (readModel?.fjChapterModels?.count)! - 1 {
            return nil
        }
        if pageChange! == (readModel?.fjChapterModels?[chapterChange!] as! FJChapterModel).pageCount! - 1 {
            chapterChange! += 1
            pageChange = 0
        }
        else
        {
            pageChange! += 1
        }
        return readVC(chapter: chapterChange!, page: pageChange!)

    }
    // MARK: ------ UIPageViewController Delegate
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            let readView = previousViewControllers.first as! FJReadViewController
            self.readVC = readView
            page = readView.recordModel?.page
            chapter = readView.recordModel?.chapter
        }
        else
        {
            self.updateReadModel(chapter: chapter!, page: page!)
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        chapter = chapterChange
        page = pageChange
    }
    func readVC(chapter: Int, page: Int) -> FJReadViewController {
        if readModel?.record?.chapter != chapter {
            self.updateReadModel(chapter: chapter, page: page)
            readModel?.record?.chapterModel?.updateFont()
        }
        readVC = FJReadViewController()
        readVC?.recordModel = readModel?.record
        readVC?.content = (readModel?.fjChapterModels?[chapter] as! FJChapterModel).stringOfPage(index: page)
        return readVC!
    }
    func updateReadModel(chapter: Int, page: Int) {
        self.chapter = chapter
        self.page = page
        readModel?.record?.chapterModel = readModel?.fjChapterModels?[chapter] as? FJChapterModel
        readModel?.record?.chapter = chapter
        readModel?.record?.page = page
        readModel?.font = FJReadConfig.shareInstance.fontSize
        FJReadModel.updateLocalModel(readModel: readModel!, url: resourceURL!)
    }
    
}

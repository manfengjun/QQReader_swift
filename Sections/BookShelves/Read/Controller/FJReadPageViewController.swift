//
//  ReadViewController.swift
//  QQReader
//
//  Created by jun on 2017/5/2.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import YYModel
class FJReadPageViewController: BaseViewController {
    var chapter: Int?                       //当前显示的章节
    var page: Int?                          //当前显示的页数
    var chapterChange: Int?                 //将要变化的章节
    var pageChange: Int?                    //将要变化的页数
    var isTransition: Bool?                 //是否开始翻页
    var resourceURL: String?
    var readVC: FJReadViewController?       //当前阅读视图
    var readModel: FJReadModel?             //阅读对象
    var statusBarHidden = true             //是否显示状态栏
    
    ///翻页控制器
    lazy var pageController:UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.pageCurl, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: nil)
        pageController.delegate = self
        pageController.dataSource = self
        return pageController
    }()
    lazy var tapGesture:UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(FJReadPageViewController.showToolMenu))
        return tap
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.barTintColor = RGBColor(r: 0, g: 0, b: 0, a: 0.3)

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.subviews[0].alpha = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuView()
        //添加阅读控制视图
        view.addSubview(pageController.view)
        addChildViewController(pageController)
//        navigationController?.barHideOnTapGestureRecognizer.addTarget(self, action: #selector(FJReadPageViewController.showToolMenu))
        view.addGestureRecognizer(tapGesture)

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
    // MARK: ------ 功能菜单
    func setupMenuView() {
        setBackButtonInNav(imageUrl: "nav_back_white.png", action: #selector(FJReadPageViewController.dismissvc))
        setRightButtonInNav(imageUrl: "nav_more_white.png", action: #selector(FJReadPageViewController.dismissvc))
        let bottomMenuView = FJBottomMenuView(frame: CGRect(x: 0, y: ScreenHeight - 49, width: ScreenWidth, height: 49))
        UIApplication.shared.keyWindow?.addSubview(bottomMenuView)
    }
    // MARK: ------ 手势
    func showToolMenu() {
        navigationController?.navigationBar.subviews[0].alpha = 1
        statusBarHidden = statusBarHidden ? false : true
        navigationController?.setNavigationBarHidden(statusBarHidden, animated: true)
        setNeedsStatusBarAppearanceUpdate()
        
    }

    // MARK: ------ 设置是否显示状态栏
    override var prefersStatusBarHidden: Bool{
        return statusBarHidden
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.default
    }
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
    // MARK: ------ 更新翻页数据
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

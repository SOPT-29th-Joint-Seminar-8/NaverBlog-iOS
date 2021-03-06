//
//  CustomTabBarController.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/11/14.
//

import UIKit

class CustomTabBarController: UITabBarController {
    let writeTab = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setTabs()
        setMiddleTab()
        
        getNotification()
    }
}

// MARK: - UI

extension CustomTabBarController {
    private func initUI() {
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }
}

// MARK: - Set Tabs

extension CustomTabBarController {
    private func setTabs() {
        let feedStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.Feed, bundle: nil)
        let feedTab = feedStoryboard.instantiateViewController(identifier: Const.ViewController.Name.Feed)
        feedTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "icFeed"), selectedImage: UIImage(named: "icFeed"))
        
        let recommendStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.Recommend, bundle: nil)
        let recommendTab = recommendStoryboard.instantiateViewController(identifier: Const.ViewController.Name.Recommend)
        recommendTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "icRecommend"), selectedImage: UIImage(named: "icRecommend"))
        
        let tab = UIViewController()
        tab.tabBarItem = UITabBarItem()
        
        let notificationTab = NotificationVC()
        notificationTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "icAlarm"), selectedImage: UIImage(named: "icAlarm"))
        
        let myStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.MyPage, bundle: nil)
        let myTab = myStoryboard.instantiateViewController(identifier: Const.ViewController.Name.Navigation)
        myTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "icProfile"), selectedImage: UIImage(named: "icProfile"))
        
        let tabs =  [feedTab, recommendTab, tab, notificationTab, myTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = myTab
    }
}


// MARK: - Set Middle Tab

extension CustomTabBarController {
    func setMiddleTab() {
        var writeTabFrame = writeTab.frame
        writeTabFrame.origin.y = view.bounds.height - writeTabFrame.height - 50
        writeTabFrame.origin.x = view.bounds.width / 2 - writeTabFrame.size.width / 2
        writeTab.frame = writeTabFrame
        
        writeTab.backgroundColor = UIColor.blogGreen
        writeTab.layer.cornerRadius = writeTabFrame.height / 2
        view.addSubview(writeTab)
        
        writeTab.setImage(UIImage(named: "icWriteStroke"), for: .normal)
        writeTab.addTarget(self, action: #selector(touchUpWriteTab(sender:)), for: .touchUpInside)
    }
    
    @objc
    private func touchUpWriteTab(sender: UIButton) {
        
    }
}

extension CustomTabBarController {
    func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(showWriteTab(_:)), name: NSNotification.Name("ShowWritTab"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hiddenWriteTab(_:)), name: NSNotification.Name("HiddenWriteTab"), object: nil)
    }
    
    @objc
    func showWriteTab(_ notification: Notification) {
        self.tabBar.isHidden = false
        self.writeTab.isHidden = false
    }
    
    @objc
    func hiddenWriteTab(_ notification: Notification) {
        self.tabBar.isHidden = true
        self.writeTab.isHidden = true
    }
}


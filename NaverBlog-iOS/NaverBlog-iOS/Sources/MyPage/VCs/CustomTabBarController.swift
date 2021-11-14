//
//  CustomTabBarController.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/11/14.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        setTabs()
        setMiddleTab()
    }
}

// MARK: - UI

extension CustomTabBarController {
    private func initUI() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = .black
        tabBar.layer.setShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
        
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            let tabBar = UITabBar()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance;
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
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
        let myTab = myStoryboard.instantiateViewController(identifier: Const.ViewController.Name.MyPage)
        myTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "icProfile"), selectedImage: UIImage(named: "icProfile"))
        
        let tabs =  [feedTab, recommendTab, tab, notificationTab, myTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = feedTab
    }
}


// MARK: - Set Middle Tab

extension CustomTabBarController {
    func setMiddleTab() {
        let writeTab = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        
        var writeTabFrame = writeTab.frame
        writeTabFrame.origin.y = view.bounds.height - writeTabFrame.height - 50
        writeTabFrame.origin.x = view.bounds.width/2 - writeTabFrame.size.width/2
        writeTab.frame = writeTabFrame
        
        writeTab.backgroundColor = UIColor.blogGreen
        writeTab.layer.cornerRadius = writeTabFrame.height/2
        view.addSubview(writeTab)
        
        writeTab.setImage(UIImage(named: "icWriteStroke"), for: .normal)
        writeTab.addTarget(self, action: #selector(touchUpWriteTab(sender:)), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
    
    @objc
    private func touchUpWriteTab(sender: UIButton) {
        selectedIndex = 2
    }
}


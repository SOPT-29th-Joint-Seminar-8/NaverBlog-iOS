//
//  CustomTabBarController.swift
//  NaverBlog-iOS
//
//  Created by Noah on 2021/11/16.
//

import UIKit

class CustomTBC: UITabBarController {
	
	static let identifier = "CustomTBC"

    override func viewDidLoad() {
        super.viewDidLoad()
		
		initUI()
		setTabs()
    }
}

// MARK: - UI

extension CustomTBC {
	private func initUI() {
		UITabBar.clearShadow()
		tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
	}
}

// MARK: - Set Tabs

extension CustomTBC {
	private func setTabs() {
		
		/// Tab Bar images
		
		let defaultImages = [
			Const.Image.icFeed,
			Const.Image.icRecommend,
			Const.Image.icAlarm,
			Const.Image.icProfile
		]
		
		let selectedImages = [
			Const.Image.icFeed,
			Const.Image.icRecommend,
			Const.Image.icAlarm,
			Const.Image.icProfile
		]
		
	
		/// ViewController Identifier
		
		let vcIdentifer = [
			Const.ViewController.Name.Feed,
			Const.ViewController.Name.Recommend,
			Const.ViewController.Name.Notification,
			Const.ViewController.Name.MyPage
		]
		
		/// StoryBoard Identifier
		
		let sbIdentifier = [
			Const.Storyboard.Name.Feed,
			Const.Storyboard.Name.Recommend,
			Const.Storyboard.Name.Notification,
			Const.Storyboard.Name.MyPage
		]
		
		/// ViewControllers Type
		
		let viewControllersType = [FeedVC.self, RecommendVC.self, NotificationVC.self, MyPageVC.self]
		
		var tabs = viewControllersType.indices.compactMap {
			createTab(vcType: viewControllersType[$0],
					  viewControllerIdentifier: vcIdentifer[$0],
					  storyboardIdentifier: sbIdentifier[$0],
					  defaultImage: defaultImages[$0],
					  selectedImage: selectedImages[$0])
		}
		 
		let tab = UIViewController()
		tab.tabBarItem = UITabBarItem()
		tabs.insert(tab, at: 2)
		
		setUpViewControllers(viewControllers: tabs, selectedViewController: tabs[0])
	}
}

// MARK: - Config Tab Bar

extension CustomTBC {
	private func createTab<T: UIViewController>(vcType: T.Type,
												viewControllerIdentifier: String,
												storyboardIdentifier: String,
												defaultImage: UIImage?,
												selectedImage: UIImage?) -> T? {

		let storyboard = UIStoryboard.init(name: storyboardIdentifier, bundle: nil)
		guard var tab = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as? T else { return nil }
		setTabBarItem(tab: &tab, defaultImage: defaultImage, selectedImage: selectedImage)
		
		return tab
	}
	
	private func setTabBarItem<T: UIViewController>(tab: inout T, defaultImage: UIImage?, selectedImage: UIImage?) {
		tab.title = ""
		tab.tabBarItem = UITabBarItem(title: "", image: defaultImage, selectedImage: selectedImage)
	}
	
	private func setUpViewControllers(viewControllers: [UIViewController], selectedViewController: UIViewController) {
		setViewControllers(viewControllers, animated: true)
		self.selectedViewController = selectedViewController
		setMiddleTab()
	}
}

// MARK: - Set Middle Tab

extension CustomTBC {
	func setMiddleTab() {
		let writeTab = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
		
		var writeTabFrame = writeTab.frame
		writeTabFrame.origin.y = view.bounds.height - writeTabFrame.height - 50
		writeTabFrame.origin.x = (view.bounds.width / 2) - (writeTabFrame.size.width / 2)
		writeTab.frame = writeTabFrame
		
		writeTab.backgroundColor = UIColor.blogGreen
		writeTab.layer.cornerRadius = (writeTabFrame.height / 2)
		view.addSubview(writeTab)
		
		writeTab.setImage(Const.Image.icWriteStroke, for: .normal)
		writeTab.addTarget(self, action: #selector(touchUpWriteTab(sender:)), for: .touchUpInside)
	}
	
	@objc
	private func touchUpWriteTab(sender: UIButton) {
		selectedIndex = 2
	}
}

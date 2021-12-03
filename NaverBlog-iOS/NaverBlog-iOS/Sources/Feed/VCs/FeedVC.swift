//
//  ViewController.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/11/13.
//

import UIKit

class FeedVC: UIViewController {
	
	var manager = FeedManager.shared
	
	// MARK: - IB Outlets
	
	@IBOutlet weak var feedTableView: UITableView? {
		didSet {
			feedTableView?.delegate = self
			feedTableView?.dataSource = self
			feedTableView?.separatorStyle = .none
		}
	}
	
	// MARK: - Life Cycle
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		setUpFeedVC()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		registerTableViewXib()
	}
}

// MARK: - Reload Table View

extension FeedVC: ReloadData {
	func reloadData() {
		feedTableView?.reloadData()
	}
	
	func setUpFeedVC() {
		self.navigationController?.navigationBar.isHidden = true
		manager.delegate = self
		manager.getMainFeed()
	}
}

// MARK: - Register Xib

extension FeedVC {
	private func registerTableViewXib() {
		let feedNib = UINib(nibName: FeedTVC.identifier, bundle: nil)
		let headerNib = UINib(nibName: FeedTableHeaderView.identifier, bundle: nil)
		
		feedTableView?.register(feedNib, forCellReuseIdentifier: FeedTVC.identifier)
		
		feedTableView?.register(headerNib, forHeaderFooterViewReuseIdentifier: FeedTableHeaderView.identifier)
	}
}

// MARK: - UITableView Delegate

extension FeedVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 163
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let feedTableHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FeedTableHeaderView.identifier) as? FeedTableHeaderView else { return UIView() }
		
		feedTableHeaderView.getHeaderConfigureAt()
		return feedTableHeaderView
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 496
	}
}

// MARK: - UITableView DataSource

extension FeedVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return manager.feedThumbnails.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTVC.identifier) as? FeedTVC else {
			return UITableViewCell()
		}
		cell.getCellConfigureAt(indexPath.row)
		
		return cell
	}
}

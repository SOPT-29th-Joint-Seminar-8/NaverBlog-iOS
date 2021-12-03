//
//  MyPageVC.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/11/13.
//

import UIKit

class MyPageVC: UIViewController {

    // MARK: - IB Outlets
    
    @IBOutlet weak var myTableView: UITableView!
    
    // MARK: - Properties
    
    private var myPageList = [MyPageDataModel]()
    private var myPageLists = [MyPagePost]()
    
    private var banner = [MyPageBanner]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getMyPageData()
        NotificationCenter.default.post(name: NSNotification.Name("ShowWritTab"), object: nil)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Cutom Methods

extension MyPageVC {
    private func setTableView() {
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        myTableView.register(UINib(nibName: MyPageTVC.identifier, bundle: nil), forCellReuseIdentifier: MyPageTVC.identifier)
        myTableView.register(UINib(nibName: "MyPageTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "MyPageTableHeaderView")
    }
    
    private func setData() {
        myPageList.append(contentsOf: [
            MyPageDataModel.init(image: "imgPost1", title: "1월도 안녕", content: "[1월 1일] 평소랑 다를 거 없는 아침인데 새해 첫날이니까 괜히 의미 부여하기 빛도...", time: "2021.2.2", likeCount: 3, commentCount: 8),
            MyPageDataModel.init(image: "imgPost2", title: "막학기 대학생 일상", content: "2020의 끝 ! 가장 신났어야 할 12월이 소소하게 지나갔다. 1. 미술사 종강 패키...", time: "2021.2.6", likeCount: 7, commentCount: 8),
            MyPageDataModel.init(image: "imgPost3", title: "우리만의", content: "11.03 오전 수업에는 아아 토끼 같은 고냥이 패키지 디쟌 컨펌받고 술 먹으러 갔다...", time: "2021.2.10", likeCount: 4, commentCount: 8)
        ])
    }
}

// MARK: - UITableView Delegate

extension MyPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 163
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyPageTableHeaderView") as! MyPageTableHeaderView
//        headerView.initHeader(image: banner[0].bannerImage, todayCount: banner[0].todayCount, totalCount: banner[0].totalCount, blogName: banner[0].blogName, profileName: banner[0].profileName, blogCategory: banner[0].blogCategory, neighborNum: banner[0].neighborNum)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 496
    }
}

// MARK: - UITableView DataSource

extension MyPageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPageLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageTVC.identifier) as? MyPageTVC else {
            return UITableViewCell()
        }
        let data = myPageLists[indexPath.row]
        cell.initCell(image: "imgPost1", title: data.title, content: data.content, time: data.createdAt, likeCount: data.heartNum, commentCount: data.commentNum)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
}

// MARK: - Cell Delegate

extension MyPageVC: MyPageCellDelegate {
    func pushToDetailVC() {
        let dvc = UIStoryboard(name: Const.Storyboard.Name.MyPageDetail, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.MyPageDetail)
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - Network

extension MyPageVC {
    func getMyPageData(){
        MyPageService.shared.getMyPageinfo { (response) in
            switch(response) {
            case .success(let mainResponse):
                guard let response = mainResponse as? MyPageResponseModel else { return }
                if let mainData = response.data {
                    self.myPageLists = mainData.posts
                    self.banner = mainData.banner
                    self.myTableView.reloadData()
                }
            case .requestErr :
                print("requestERR")
            case .pathErr :
                print("pathERR")
            case .serverErr:
                print("serverERR")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}

//
//  RecommendVC.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/11/13.
//

import UIKit

class RecommendVC: UIViewController {

    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    @IBOutlet weak var commentTableView: UITableView!
    
    var comment: [CommentDataModel] = []
    var replyComment: [ReplyCommentDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerCell()
        setDummyData()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        customNavigationBar.setup(title: "글 댓글", commentCount: comment.count)
    }

    private func registerCell() {
        let nibName = UINib(nibName: CommentTVC.identifier, bundle: nil)
        commentTableView.register(nibName, forCellReuseIdentifier: CommentTVC.identifier)
    }
    
    private func setupTableView() {
        commentTableView.dataSource = self
        commentTableView.delegate = self
        commentTableView.rowHeight = UITableView.automaticDimension
        commentTableView.estimatedRowHeight = 150
    }
    
    private func setDummyData() {
        comment.append(contentsOf: [
            CommentDataModel(userProfileImage: "icColorTag", userName: "채채", comment: "디자인 잘 하고 싶다❤️❤️✌️", date: Date(), likeCount: 1, replyCommentData: [
                ReplyCommentDataModel(userProfileImage: "icColorTag", userName: "종화아", comment: "감사합니다~😘", date: Date(), likeCount: 1),
            ], isOpen: false),
            CommentDataModel(userProfileImage: "icColorTag", userName: "솝트 디자인", comment: "홍대입구역 한빛 대관 리더스홀\n(서대문구 연희로2길 76 한빛빌딩)\n시간 : 2시 - 5시 (3시간)", date: Date(), likeCount: 0, replyCommentData: [
                ReplyCommentDataModel(userProfileImage: "icColorTag", userName: "종화아", comment: "감사합니다~😘", date: Date(), likeCount: 1),
                ReplyCommentDataModel(userProfileImage: "icColorTag", userName: "채채", comment: "정보 감사합니다 :)", date: Date(), likeCount: 1)
            ], isOpen: false),
            CommentDataModel(userProfileImage: "icColorTag", userName: "WE SOPT", comment: "기대가 됩니다!", date: Date(), likeCount: 1, replyCommentData: [
                ReplyCommentDataModel(userProfileImage: "icColorTag", userName: "이십구기", comment: "화이팅❤️❤️✌️", date: Date(), likeCount: 1)
            ], isOpen: false)
        ])
    }
}

extension RecommendVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            comment[indexPath.section].isOpen.toggle()
            tableView.reloadSections([indexPath.section], with: .none)
        }
    }
}

extension RecommendVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return comment.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = comment[section].isOpen ? comment[section].replyCommentData.count + 1 : 1
        return numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTVC.identifier) as? CommentTVC
        else { return UITableViewCell() }
        let currentComment = comment[indexPath.section]
        
        if indexPath.row == 0 {
            cell.setup(userProfileImage: currentComment.userProfileImage,
                       userName: currentComment.userName,
                       comment: currentComment.comment,
                       date: currentComment.date,
                       likeCount: currentComment.likeCount,
                       replyCommentCount: currentComment.replyCommentData.count)
            cell.setCommentLayout()
            
            return cell
        } else {
            let currentReplyComment = currentComment.replyCommentData[indexPath.row - 1]
            cell.setup(userProfileImage: currentReplyComment.userProfileImage,
                       userName: currentReplyComment.userName,
                       comment: currentReplyComment.comment,
                       date: currentReplyComment.date,
                       likeCount: currentReplyComment.likeCount,
                       replyCommentCount: nil)
            cell.setReplyCommentLayout()
            
            return cell
        }
    }
}

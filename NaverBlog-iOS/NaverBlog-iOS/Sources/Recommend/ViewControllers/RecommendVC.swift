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
    
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCommentData()
        setupTableView()
        registerCell()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        customNavigationBar.setup(title: "글 댓글", commentCount: comments.count)
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
}

extension RecommendVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            comments[indexPath.section].isOpen?.toggle()
            tableView.reloadSections([indexPath.section], with: .none)
            guard let currentCell = tableView.cellForRow(at: indexPath) as? CommentTVC else { return }
            currentCell.setCommentMoreLabel(isOpen: comments[indexPath.section].isOpen ?? false)
        }
    }
}

extension RecommendVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = comments[section].isOpen ?? false ? comments[section].reply.count + 1 : 1
        return numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTVC.identifier) as? CommentTVC
        else { return UITableViewCell() }
        let currentComment = comments[indexPath.section]
        
        if indexPath.row == 0 {
            cell.setup(userProfileImage: "icColorTag",
                       userName: currentComment.userName,
                       comment: currentComment.content,
                       date: currentComment.createdAt,
                       likeCount: currentComment.heartNum,
                       replyCommentCount: currentComment.reply.count)
            cell.setCommentLeadingLayout(constant: 20)
            
            return cell
        } else {
            let currentReplyComment = currentComment.reply[indexPath.row-1]
            cell.setup(userProfileImage: "icColorTag",
                       userName: currentReplyComment.userName,
                       comment: currentReplyComment.content,
                       date: currentReplyComment.createdAt,
                       likeCount: currentReplyComment.heartNum,
                       replyCommentCount: nil)
            cell.setCommentLeadingLayout(constant: 54)
            
            return cell
        }
    }
}

extension RecommendVC {
    func getCommentData() {
        CommentManager.shared.inquiryComment(postId: 1) { responseData in
            switch responseData {
            case .success(let commentResponse):
                guard let response = commentResponse as? CommentResponse else { return }
                guard let commentData = response.data else { return }
                self.comments = commentData.comments
                self.commentTableView.reloadData()
            case .requestErr(_):
                print("requestErr")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}

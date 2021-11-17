//
//  MyPageDetailVC.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/11/16.
//

import UIKit

class MyPageDetailVC: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var cutomNavigationBar: UIView!
    @IBOutlet weak var myTableView: UITableView!
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var backgroundView: UIVisualEffectView = {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
        effectView.layer.cornerRadius = 8
        effectView.layer.cornerCurve = .continuous
        effectView.clipsToBounds = true
        effectView.translatesAutoresizingMaskIntoConstraints = false
        return effectView
    }()
    
    private lazy var upButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "btnGoup"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    
    private var commentList = [MyPageDetailDataModel]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setToolBar()
        setTableView()
        setData()
    }
}

extension MyPageDetailVC {
    private func initUI() {
        view.addSubview(backgroundView)
        view.addSubview(upButton)
        
        backgroundView.contentView.addSubview(textField)
        
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            upButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            upButton.bottomAnchor.constraint(equalTo: backgroundView.contentView.topAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: backgroundView.contentView.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: backgroundView.contentView.trailingAnchor, constant: -8),
            textField.topAnchor.constraint(equalTo: backgroundView.contentView.topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: backgroundView.contentView.bottomAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            view.keyboardLayoutGuide.topAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: 8
            )
        ])
    }
    
    private func setToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
                
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(done))
                
        toolbar.setItems([doneButton], animated: false)
                
        //toolbar를 넣고싶은 textField 및 textView 필자의 경우 recommendDataTextView
        textField.inputAccessoryView = toolbar
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        setupNavigationBar(customNavigationBarView: cutomNavigationBar, title: "글 댓글 \(commentList.count)")
    }
    
    private func setTableView() {
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        myTableView.estimatedRowHeight = 300
        myTableView.rowHeight = UITableView.automaticDimension
        
        myTableView.register(UINib(nibName: MyPageDetailTVC.identifier, bundle: nil), forCellReuseIdentifier: MyPageDetailTVC.identifier)
        myTableView.register(UINib(nibName: LastCommentTVC.identifier, bundle: nil), forCellReuseIdentifier: LastCommentTVC.identifier)
    }
    
    private func setData() {
        commentList.append(contentsOf: [
            MyPageDetailDataModel(userImage: "icColorTag", userName: "채채", comment: "디자인 잘 하고 싶다 ❤❤✌", time: "2020. 8. 26. 19:05", likeCount: 1, isHide: true),
            MyPageDetailDataModel(userImage: "icColorTag", userName: "솝트 디자인", comment: "홍대입구역 한빛 대관 리더스홀\n(서대문구 연희로2길 76 한빛빌딩)\n시간 : 2시 - 5시 (3시간)", time: "2020. 8. 24. 20:05", likeCount: 1, isHide: true),
            MyPageDetailDataModel(userImage: "icColorTag", userName: "WE SOPT", comment: "기대가 됩니다 !", time: "2020. 8. 22. 19:05", likeCount: 1, isHide: true)
        ])
    }
}

// MARK: - @objc

extension MyPageDetailVC {
    @objc
    func done() {
        self.view.endEditing(true)
    }
}

// MARK: - TableView Delegate

extension MyPageDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return tableView.rowHeight
        case 1:
            return 43
        default:
            return 0
        }
    }
}

// MARK: - TableView DataSource

extension MyPageDetailVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return commentList.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageDetailTVC.identifier) as? MyPageDetailTVC else { return UITableViewCell() }
            cell.initCell(userImage: commentList[indexPath.row].userImage, userName: commentList[indexPath.row].userName, comment: commentList[indexPath.row].comment, time: commentList[indexPath.row].time, likeCount: commentList[indexPath.row].likeCount, isHide: commentList[indexPath.row].isHide)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LastCommentTVC.identifier) as? LastCommentTVC else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - TextField Delegate

extension MyPageDetailVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



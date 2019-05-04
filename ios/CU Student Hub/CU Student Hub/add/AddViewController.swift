//
//  AddViewController.swift
//  CU Student Hub
//
//  Created by Lauren on 5/1/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    var courseTableView: UITableView!
    var courseArray: [Course]!
    var searchTextField: UITextField!
    var searchButton: UIButton!
    var addButton: UIButton!
    
    let textCellReuseIdentifier = "textCellReuseIdentifier"
    let padding: CGFloat = 8
    let headerHeight: CGFloat = 30
    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//        self.courseArray = nil
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Loading")
        courseArray = []
        title = "Add"
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        
        courseTableView = UITableView()
        courseTableView.allowsSelection = false
        courseTableView.delegate = self
        courseTableView.dataSource = self
        courseTableView.register(CourseTableViewCell.self, forCellReuseIdentifier: textCellReuseIdentifier)
        courseTableView.tableFooterView = UIView() // so there's no empty lines at the bottom
        view.addSubview(courseTableView)
        
        searchTextField = UITextField()
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.text = "Input the course code here"
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .white
        searchTextField.textAlignment = .center
        searchTextField.clearsOnBeginEditing = true
        view.addSubview(searchTextField)
        
        searchButton = UIButton()
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.backgroundColor = UIColor.lightGray
        //        searchButton.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        view.addSubview(searchButton)
        
        addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.backgroundColor = UIColor.lightGray
        //        searchButton.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        view.addSubview(addButton)
        
        setupConstraints()
        getCourses()
    }
    
    func setupConstraints() {
        courseTableView.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp_bottom)
            make.bottom.equalTo(view.snp_bottomMargin)
            make.left.equalTo(view.snp_leftMargin)
            make.right.equalTo(view.snp_rightMargin)
        }
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: searchButton.bottomAnchor),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    func getCourses(){
        NetworkManager.getClasses(completion: { courses in
            self.courseArray = courses
            DispatchQueue.main.async {
                self.courseTableView.reloadData()
            }
        })
    }
    
    @objc func pushProfileViewController() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    @objc func pushAddViewController() {
        let addViewController = AddViewController()
        navigationController?.pushViewController(addViewController, animated: true)
    }
    
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellReuseIdentifier, for: indexPath) as! CourseTableViewCell
        cell.configure(for: courseArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

//
//  MainViewController.swift
//  CU Student Hub
//
//  Created by Lauren on 4/23/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    var courseTableView: UITableView!
    var courseArray: [Course]!
    var searchTextField: UITextField!
    var searchButton: UIButton!
    var addButton: UIBarButtonItem!
    var profileButton: UIBarButtonItem!
    
    let reuseIdentifier = "ClassTableViewCellReuse"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("Loading")
        title = "Student Hub"
        view.backgroundColor = .white
        courseArray = []
        
        
        addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(pushAddViewController))
        self.navigationItem.rightBarButtonItem = addButton
        profileButton = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(pushProfileViewController))
        self.navigationItem.leftBarButtonItem = profileButton
        
        courseTableView = UITableView()
        courseTableView.allowsSelection = true
        courseTableView.delegate = self
        courseTableView.dataSource = self
        courseTableView.register(CourseTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
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
        
        setupConstraints()
        getCourses()
    }
    
    func setupConstraints() {

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
        
        courseTableView.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CourseTableViewCell
        cell.configure(for: courseArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let course = courseArray[index]
        System.courseSelected = course
        let locationViewController = HubViewController()
        navigationController?.pushViewController(locationViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.courseTableView.indexPathForSelectedRow {
            self.courseTableView.deselectRow(at: index, animated: true)
        }
    }
}

//extension MainViewController: UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return courseArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: textCellReuseIdentifier, for: indexPath) as! CourseCollectionViewCell
//        let course = courseArray[indexPath.item]
//        cell.configure(for: course)
//        return cell
//    }
//}
//
//extension MainViewController: UICollectionViewDelegate{
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        courseArray.remove(at: indexPath.item)
//        // reload the collectionview
//        collectionView.reloadData()
//    }
//}
//
//extension MainViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let length = collectionView.frame.width - 2 * padding
//        return  CGSize(width: length, height: length)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: headerHeight)
//    }
//
//}


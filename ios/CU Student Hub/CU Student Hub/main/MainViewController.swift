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

    var courseCollectionView: UICollectionView!
    var courseArray: [CornellRosterData]!
    var searchTextField: UITextField!
    var searchButton: UIButton!
    var addButton: UIBarButtonItem!
    var profileButton: UIBarButtonItem!
    
    let textCellReuseIdentifier = "textCellReuseIdentifier"
    let padding: CGFloat = 8
    let headerHeight: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Loading")
        courseArray = []
        title = "Student Hub"
        view.backgroundColor = .white
        addButton = UIBarButtonItem()
        addButton.title = "Add"
        self.navigationItem.rightBarButtonItem = addButton
        profileButton = UIBarButtonItem()
        profileButton.title = "Profile"
        self.navigationItem.leftBarButtonItem = profileButton
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        
        courseCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        courseCollectionView.translatesAutoresizingMaskIntoConstraints = false
        courseCollectionView.backgroundColor = .white
        courseCollectionView.dataSource = self
        courseCollectionView.delegate = self
        courseCollectionView.register(CourseCollectionViewCell.self, forCellWithReuseIdentifier: textCellReuseIdentifier)
        view.addSubview(courseCollectionView)
        
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
            courseCollectionView.topAnchor.constraint(equalTo: searchButton.bottomAnchor),
            courseCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            courseCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            courseCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
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
    }
    
    func getCourses(){
        NetworkManager.getCourses { rosterData in
            self.courseArray = rosterData
            DispatchQueue.main.async {
                self.courseCollectionView.reloadData()
            }
        }
    }
}
    
extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: textCellReuseIdentifier, for: indexPath) as! CourseCollectionViewCell
        let course = courseArray[indexPath.item]
        cell.configure(for: course)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        courseArray.remove(at: indexPath.item)
        // reload the collectionview
        collectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (collectionView.frame.width - 4 * padding) / 3
        return  CGSize(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: headerHeight)
    }
    
}

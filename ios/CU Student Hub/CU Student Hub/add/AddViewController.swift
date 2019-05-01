//
//  AddViewController.swift
//  CU Student Hub
//
//  Created by Lauren on 5/1/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    var courseCollectionView: UICollectionView!
    var courseArray: [CornellRosterData]!
    var searchTextField: UITextField!
    var searchButton: UIButton!
    var addButton: UIButton!
    
    let textCellReuseIdentifier = "textCellReuseIdentifier"
    let padding: CGFloat = 8
    let headerHeight: CGFloat = 30
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.courseArray = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        NSLayoutConstraint.activate([
            courseCollectionView.topAnchor.constraint(equalTo: addButton.bottomAnchor),
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
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: searchButton.bottomAnchor),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
    
    @objc func pushProfileViewController() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    @objc func pushAddViewController() {
        let addViewController = AddViewController()
        navigationController?.pushViewController(addViewController, animated: true)
    }
    
}

extension AddViewController: UICollectionViewDataSource{
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

extension AddViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        courseArray.remove(at: indexPath.item)
        // reload the collectionview
        collectionView.reloadData()
    }
}

extension AddViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (collectionView.frame.width - 4 * padding) / 3
        return  CGSize(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: headerHeight)
    }
    
}

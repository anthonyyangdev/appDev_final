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
    var courseArray: [Course]!
    var searchTextField: UITextField!
    var searchButton: UIButton!
    var addButton: UIButton!
    var profileButton: UIButton!
    
    let photoCellReuseIdentifier = "photoCellReuseIdentifier"
    let padding: CGFloat = 8
    let headerHeight: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Student Hub"
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
        courseCollectionView.register(CourseCollectionViewCell.self, forCellWithReuseIdentifier: photoCellReuseIdentifier)
        view.addSubview(courseCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            courseCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            courseCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            courseCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            courseCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
}
    
extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellReuseIdentifier, for: indexPath) as! CourseCollectionViewCell
        let course = courseArray[indexPath.item]
        cell.configure(for: course)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // let person = peopleArray[indexPath.item]
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

//
//  HubViewController.swift
//  CU Student Hub
//
//  Created by Lauren on 4/23/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class HubViewController: UIViewController {
    
    var locationCollectionView: UICollectionView!
    var locationArray: [Location]!
    var searchTextField: UITextField!
    var searchButton: UIButton!
    
    let photoCellReuseIdentifier = "photoCellReuseIdentifier"
    let padding: CGFloat = 8
    let headerHeight: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Locations"
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        
        locationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        locationCollectionView.translatesAutoresizingMaskIntoConstraints = false
        locationCollectionView.backgroundColor = .white
        locationCollectionView.dataSource = self
        locationCollectionView.delegate = self
        locationCollectionView.register(LocationCollectionViewCell.self, forCellWithReuseIdentifier: photoCellReuseIdentifier)
        view.addSubview(locationCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            locationCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            locationCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
}

extension HubViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellReuseIdentifier, for: indexPath) as! LocationCollectionViewCell
        let location = locationArray[indexPath.item]
        cell.configure(for: location)
        return cell
    }
}

extension HubViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // let person = peopleArray[indexPath.item]
        locationArray.remove(at: indexPath.item)
        // reload the collectionview
        collectionView.reloadData()
    }
}

extension HubViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (collectionView.frame.width - 4 * padding) / 3
        return  CGSize(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: headerHeight)
    }
    
}


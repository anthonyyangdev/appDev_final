//
//  LocationCollectionViewCell.swift
//  CU Student Hub
//
//  Created by Lauren on 4/23/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    
    var photoImageView: UIImageView!
    var name: UILabel!
    var type: UILabel!
    var openTime: UILabel!
    var heartImageView: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        photoImageView = UIImageView(frame: .zero)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFit
        heartImageView = UIImageView(frame: .zero)
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        heartImageView.contentMode = .scaleAspectFit
        name = UILabel(frame: .init())
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        type = UILabel(frame: .init())
        type.textColor = .black
        type.font = UIFont.systemFont(ofSize: 15, weight: .light)
        type.translatesAutoresizingMaskIntoConstraints = false
        openTime = UILabel(frame: .init())
        openTime.textColor = .black
        openTime.font = UIFont.systemFont(ofSize: 15, weight: .light)
        openTime.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(photoImageView)
        contentView.addSubview(name)
        contentView.addSubview(type)
        contentView.addSubview(openTime)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -80)
            ])
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            name.heightAnchor.constraint(equalToConstant: 20),
            name.widthAnchor.constraint(equalToConstant: 130)
            ])
        NSLayoutConstraint.activate([
            type.topAnchor.constraint(equalTo: name.bottomAnchor),
            type.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            type.heightAnchor.constraint(equalToConstant: 20),
            type.widthAnchor.constraint(equalToConstant: 80)
            ])
        NSLayoutConstraint.activate([
            openTime.topAnchor.constraint(equalTo: type.bottomAnchor),
            openTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            openTime.heightAnchor.constraint(equalToConstant: 20),
            openTime.widthAnchor.constraint(equalToConstant: 80)
            ])
    }
    
    func configure(for location: Location){
        photoImageView.image = location.profileImage
        name.text = location.name
        type.text = location.type
        openTime.text = location.openTime
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

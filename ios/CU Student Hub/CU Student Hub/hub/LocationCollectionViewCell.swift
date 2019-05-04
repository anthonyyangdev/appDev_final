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
    let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.isOpaque = true
        
        photoImageView = UIImageView()
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.image = UIImage(named: "questions")
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFit
        contentView.addSubview(photoImageView)
        
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "null"
        contentView.addSubview(name)
        
        type = UILabel()
        type.translatesAutoresizingMaskIntoConstraints = false
        type.text = "null"
        contentView.addSubview(type)
        
        openTime = UILabel()
        openTime.translatesAutoresizingMaskIntoConstraints = false
        openTime.text = "null"
        openTime.textAlignment = .right
        contentView.addSubview(openTime)
        
        heartImageView = UIImageView()
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        heartImageView.image = UIImage(named: "heart")
        heartImageView.clipsToBounds = true
        heartImageView.contentMode = .scaleAspectFit
        contentView.addSubview(heartImageView)
        
        setupConstraints()

    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            photoImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height*2/3),
            photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            name.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10),
            name.heightAnchor.constraint(equalToConstant: contentView.frame.height/6),
            ])
        
        NSLayoutConstraint.activate([
            type.topAnchor.constraint(equalTo: name.bottomAnchor),
            type.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            type.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            type.trailingAnchor.constraint(equalTo: name.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            openTime.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            openTime.bottomAnchor.constraint(equalTo: name.bottomAnchor),
            openTime.leadingAnchor.constraint(equalTo: name.trailingAnchor),
            openTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        
        NSLayoutConstraint.activate([
            heartImageView.topAnchor.constraint(equalTo: openTime.bottomAnchor),
            heartImageView.leadingAnchor.constraint(equalTo: type.trailingAnchor),
            heartImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            heartImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])

    }
    
    func configure(for location: Location){
        name.text = location.name
        type.text = location.type
        openTime.text = location.times
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

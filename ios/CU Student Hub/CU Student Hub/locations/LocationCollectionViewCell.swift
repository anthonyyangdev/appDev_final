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
    var heartImageView: UIImageView!
    let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        contentView.isOpaque = true
        contentView.layer.cornerRadius = 10
        
        photoImageView = UIImageView()
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.image = UIImage(named: "questions")
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        contentView.addSubview(photoImageView)
        
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "null"
        name.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        name.numberOfLines = 0
        name.lineBreakMode = .byWordWrapping
        contentView.addSubview(name)
        
        
        heartImageView = UIImageView()
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        heartImageView.image = UIImage(named: "white_heart")
        heartImageView.clipsToBounds = true
        heartImageView.contentMode = .scaleAspectFit
        contentView.addSubview(heartImageView)
        
        setupConstraints()

    }
    
    func setupConstraints(){
        
        let heartLength: CGFloat = 25
    
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -contentView.frame.height/3),
            photoImageView.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            name.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            name.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -contentView.frame.width/5),
            name.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            ])
        
        NSLayoutConstraint.activate([
            heartImageView.centerYAnchor.constraint(equalTo: name.centerYAnchor),
            heartImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            heartImageView.heightAnchor.constraint(equalToConstant: heartLength),
            heartImageView.widthAnchor.constraint(equalToConstant: heartLength)
            ])

    }
    
    func configure(for location: Location){
        name.text = location.name
        photoImageView.image = location.img
        heartImageView.image = location.isFavorite ? UIImage(named: "red_heart") : UIImage(named: "white_heart")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

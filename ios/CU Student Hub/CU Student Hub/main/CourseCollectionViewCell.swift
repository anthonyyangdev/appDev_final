//
//  CourseCollectionViewCell.swift
//  CU Student Hub
//
//  Created by Lauren on 4/23/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class CourseCollectionViewCell: UICollectionViewCell {
    
    var photoImageView: UIImageView!
    var name: UILabel!
    var type: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        photoImageView = UIImageView(frame: .zero)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFit
        name = UILabel(frame: .init())
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        type = UILabel(frame: .init())
        type.textColor = .black
        type.font = UIFont.systemFont(ofSize: 15, weight: .light)
        type.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(photoImageView)
        contentView.addSubview(name)
        contentView.addSubview(type)
        
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
    }
    
    func configure(for course: Course){
        photoImageView.image = course.profileImage
        name.text = course.name
        type.text = course.type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

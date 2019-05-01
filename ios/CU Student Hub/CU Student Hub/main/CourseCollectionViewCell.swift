//
//  CourseCollectionViewCell.swift
//  CU Student Hub
//
//  Created by Lauren on 4/23/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class CourseCollectionViewCell: UICollectionViewCell {
    
    var name: UILabel!
    var type: UILabel!
    var sessionCode: UILabel!
    var location: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        name = UILabel(frame: .init())
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        type = UILabel(frame: .init())
        type.textColor = .black
        type.font = UIFont.systemFont(ofSize: 15, weight: .light)
        type.translatesAutoresizingMaskIntoConstraints = false
        sessionCode = UILabel(frame: .init())
        sessionCode.textColor = .black
        sessionCode.font = UIFont.systemFont(ofSize: 15, weight: .light)
        sessionCode.translatesAutoresizingMaskIntoConstraints = false
        location = UILabel(frame: .init())
        location.textColor = .black
        location.font = UIFont.systemFont(ofSize: 15, weight: .light)
        location.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
        contentView.addSubview(type)
        contentView.addSubview(sessionCode)
        contentView.addSubview(location)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            name.heightAnchor.constraint(equalToConstant: 20),
            name.widthAnchor.constraint(equalToConstant: 130)
            ])
        NSLayoutConstraint.activate([
            sessionCode.topAnchor.constraint(equalTo: name.bottomAnchor),
            sessionCode.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sessionCode.heightAnchor.constraint(equalToConstant: 20),
            sessionCode.widthAnchor.constraint(equalToConstant: 130)
            ])
        NSLayoutConstraint.activate([
            type.topAnchor.constraint(equalTo: sessionCode.bottomAnchor),
            type.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            type.heightAnchor.constraint(equalToConstant: 20),
            type.widthAnchor.constraint(equalToConstant: 130)
            ])
        NSLayoutConstraint.activate([
            location.topAnchor.constraint(equalTo: type.bottomAnchor),
            location.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            location.heightAnchor.constraint(equalToConstant: 20),
            location.widthAnchor.constraint(equalToConstant: 130)
            ])
    }
    
    func configure(for course: CornellRosterData){
        name.text = course.descr
        type.text = course.strm
        sessionCode.text = course.defaultSessionCode
        location.text = course.defaultLocation
    }
}

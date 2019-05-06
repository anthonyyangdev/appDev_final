//
//  LocationTableViewCell.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 5/5/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class CourseSelectedTableViewCell: UITableViewCell {

    var value: UILabel!
    var courseID: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        value = UILabel()
        value.text = "null"
        value.font = UIFont.systemFont(ofSize: 15)
        value.numberOfLines = 0
        value.lineBreakMode = .byWordWrapping
        contentView.addSubview(value)
        
        courseID = UILabel()
        courseID.translatesAutoresizingMaskIntoConstraints = false
        courseID.textAlignment = .right
        courseID.text = "null"
        courseID.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(courseID)

        setupConstraints()
    }
    
    func configure(for course: Course) {
        value.text = course.titleShort
        courseID.text = "\(course.subject)\(course.catalogNbr)"
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            courseID.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            courseID.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            courseID.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            courseID.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        value.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(contentView.snp.leading).offset(8)
            make.trailing.equalTo(courseID.snp.leading)
        }
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

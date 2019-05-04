//
//  CourseCollectionViewCell.swift
//  CU Student Hub
//
//  Created by Lauren on 4/23/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//
import UIKit

class CourseTableViewCell: UITableViewCell {
    
    var name: UILabel!
    var subject: UILabel!
    var courseCode: UILabel!
    
    let padding: CGFloat = 8
    let nameLabelHeight: CGFloat = 16
    var nameLabelWidth: CGFloat = 0
    let instructorLabelHeight: CGFloat = 14
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.nameLabelWidth = contentView.bounds.width * 3/4

        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .black
        name.font = .systemFont(ofSize: 14)
        
        courseCode = UILabel()
        courseCode.translatesAutoresizingMaskIntoConstraints = false
        courseCode.textColor = .gray
        courseCode.textAlignment = .right
        courseCode.font = .systemFont(ofSize: 12)
        
        subject = UILabel()
        subject.translatesAutoresizingMaskIntoConstraints = false
        subject.textColor = .gray
        subject.font = .systemFont(ofSize: 14)
        
        contentView.addSubview(name)
        contentView.addSubview(courseCode)
        contentView.addSubview(subject)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            name.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding),
            name.widthAnchor.constraint(equalToConstant: nameLabelWidth),
            name.heightAnchor.constraint(equalToConstant: nameLabelHeight)
        ])
        
//        name.snp.makeConstraints { make in
//            make.leading.top.equalToSuperview().offset(padding)
//            make.height.equalTo(nameLabelHeight)
//        }
        
        
        NSLayoutConstraint.activate([
            courseCode.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: padding),
            courseCode.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            courseCode.topAnchor.constraint(equalTo: name.topAnchor),
            courseCode.heightAnchor.constraint(equalToConstant: nameLabelHeight)
        ])
        
//        courseCode.snp.makeConstraints { make in
//            make.leading.equalTo(name.snp.trailing).offset(padding)
//            make.trailing.equalToSuperview().offset(-padding)
//            make.top.height.equalTo(name)
//        }
        
        NSLayoutConstraint.activate([
            subject.topAnchor.constraint(equalTo: name.bottomAnchor, constant: padding),
            subject.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            subject.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            subject.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
//
//        courseCode.snp.makeConstraints { make in
//            make.leading.equalTo(name.snp.leading)
//            make.top.equalTo(name.snp.bottom).offset(padding)
//            make.height.equalTo(subject)
//        }
    }
    
    func configure(for course: Course) {
        name.text = "\(course.titleShort)"
        subject.text = "(\(course.subject) \(course.catalogNbr))"
        courseCode.text = course.subject
        //        contentView.backgroundColor = course.enrolled ? UIColor.green.withAlphaComponent(0.1) : UIColor.red.withAlphaComponent(0.1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


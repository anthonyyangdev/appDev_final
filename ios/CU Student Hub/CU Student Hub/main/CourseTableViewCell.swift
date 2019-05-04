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
    let instructorLabelHeight: CGFloat = 14
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        name = UILabel()
        name.textColor = .black
        name.font = .systemFont(ofSize: 14)
        
        courseCode = UILabel()
        courseCode.textColor = .gray
        courseCode.font = .systemFont(ofSize: 12)
        
        subject = UILabel()
        subject.textColor = .gray
        subject.font = .systemFont(ofSize: 14)
        
        contentView.addSubview(name)
        contentView.addSubview(courseCode)
        contentView.addSubview(subject)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        name.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(padding)
            make.height.equalTo(nameLabelHeight)
        }
        
        courseCode.snp.makeConstraints { make in
            make.leading.equalTo(name.snp.trailing).offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.top.height.equalTo(name)
        }
        
        courseCode.snp.makeConstraints { make in
            make.leading.equalTo(name.snp.leading)
            make.top.equalTo(name.snp.bottom).offset(padding)
            make.height.equalTo(subject)
        }
    }
    
//    func getCourses(){
//        NetworkManager.getClasses(completion: { courses in
//            self.courseArray = courses
//            DispatchQueue.main.async {
//                self.courseTableView.reloadData()
//            }
//        })
//    }
    
    func configure(for course: Course) {
        name.text = "\(course.titleShort)"
        subject.text = "(CS \(course.catalogNbr))"
        courseCode.text = course.subject
        //        contentView.backgroundColor = course.enrolled ? UIColor.green.withAlphaComponent(0.1) : UIColor.red.withAlphaComponent(0.1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


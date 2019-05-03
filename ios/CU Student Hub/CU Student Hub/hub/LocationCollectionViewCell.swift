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
        
        name = UILabel(frame: .init())
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            name.heightAnchor.constraint(equalToConstant: 20),
            name.widthAnchor.constraint(equalToConstant: 130)
            ])
    }
    
    func configure(for location: Location){
        name.text = location.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

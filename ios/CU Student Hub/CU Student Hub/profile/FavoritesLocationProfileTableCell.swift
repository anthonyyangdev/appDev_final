//
//  FavoritesLocationProfileTableCell.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 5/5/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class FavoritesLocationProfileTableCell: UITableViewCell {

    var value: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        value = UILabel()
        value.text = "null"
        value.numberOfLines = 0
        value.lineBreakMode = .byWordWrapping
        contentView.addSubview(value)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for location: Location) {
        value.text = location.name
    }
    
    private func setupConstraints() {
        value.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().offset(5)
        }
    }
}

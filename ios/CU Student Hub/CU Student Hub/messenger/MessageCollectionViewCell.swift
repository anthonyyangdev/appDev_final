//
//  MessageCollectionViewCell.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/26/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
 
    var profilePic: UIImageView!
    var messageContent: UILabel!
    
    init() {
        super.init(frame: .zero)
        profilePic = UIImageView()
        messageContent = UILabel()
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {

        let messageLength = contentView.bounds.width*3/4
        
        NSLayoutConstraint.activate([
            messageContent.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            messageContent.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            messageContent.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            messageContent.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: messageLength)
        ])

        NSLayoutConstraint.activate([
            profilePic.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            profilePic.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            profilePic.leadingAnchor.constraint(equalTo: messageContent.trailingAnchor),
            profilePic.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    func configure(msg: Message) {
        profilePic = UIImageView(image: msg.image)
        messageContent.text = msg.message
    }
    
}

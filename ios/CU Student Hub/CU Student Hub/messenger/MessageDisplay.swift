//
//  MessageDisplay.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/22/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class MessageDisplay: UIView {
    
    // Stores the array of messages that gets displayed.
    var messages: [Message]!
    
    // The UI Component that renders the messages
    var messageDisplay: UICollectionView!

    /*
     https://medium.com/@andersongusmao/uicollectionview-using-cells-with-different-heights-6627f053cdcd
     */
    
    let messageCellReuserID = "messageCellReuserID"
    
    init() {
        super.init(frame: .zero)
        
        messages = []
        
        messageDisplay = UICollectionView()
        messageDisplay.dataSource = self
        messageDisplay.delegate = self
        messageDisplay.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: messageCellReuserID)
        
        messageDisplay.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(messageDisplay)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MessageDisplay: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.count
        let msg = messages[index]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: messageCellReuserID, for: indexPath) as! MessageCollectionViewCell
        cell.configure(msg: msg)
        return cell
    }
    
}

extension MessageDisplay: UICollectionViewDelegate {
    
}

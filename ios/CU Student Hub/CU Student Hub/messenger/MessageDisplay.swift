//
//  MessageDisplay.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/22/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class MessageDisplay: UIScrollView {
    
    // Stores the array of messages that gets displayed.
    var messages: [Message]!
    
    // The UI Component that renders the messages
    var messageDisplay: UICollectionView!
    
    init() {
        super.init(frame: .zero)
        
        messages = []
        messageDisplay = UICollectionView()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

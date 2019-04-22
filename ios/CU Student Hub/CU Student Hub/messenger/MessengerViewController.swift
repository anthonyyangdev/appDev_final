//
//  MessengerViewController.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/22/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class MessengerViewController: UIViewController {

    // Main body of this screen. Contains the display of the messages in the chat.
    var textDisplay: MessageDisplay!
    var textInput: UITextView!
    var pushMessage: UIButton!
    var chatRoom: String!
    
    init(chatName: String) {
        super.init(nibName: nil, bundle: nil)
        self.chatRoom = chatName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        textDisplay = MessageDisplay()
        textDisplay.translatesAutoresizingMaskIntoConstraints = false
        
        textInput = UITextView()
        textInput.translatesAutoresizingMaskIntoConstraints = false
        
        pushMessage = UIButton()
        pushMessage.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}

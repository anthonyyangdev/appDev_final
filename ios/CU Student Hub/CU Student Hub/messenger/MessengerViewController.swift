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
        view.addSubview(textDisplay)
        
        textInput = UITextView()
        textInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textInput)
        
        pushMessage = UIButton()
        pushMessage.translatesAutoresizingMaskIntoConstraints = false
        pushMessage.setTitle("Send", for: .normal) // TODO: Change to a send image.
        view.addSubview(pushMessage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        let textHeight = view.bounds.height/11
        let textWidth = view.bounds.width*6/8
        
        NSLayoutConstraint.activate([
            textDisplay.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textDisplay.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textDisplay.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            textDisplay.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -textHeight)
        ])
        
        NSLayoutConstraint.activate([
            textInput.topAnchor.constraint(equalTo: textDisplay.bottomAnchor),
            textInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -textWidth),
            textInput.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            pushMessage.topAnchor.constraint(equalTo: textDisplay.bottomAnchor),
            pushMessage.leadingAnchor.constraint(equalTo: textInput.trailingAnchor),
            pushMessage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pushMessage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
}

//
//  MessengerViewController.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/22/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit
import MessageKit
import MessageInputBar


struct Member {
    let name: String
    let color: UIColor
}

struct MessageTest {
    let member: Member
    let text: String
    let messageId: String
}

extension MessageTest: MessageType {
    var sender: Sender {
        return Sender(id: member.name, displayName: member.name)
    }
    
    var sentDate: Date {
        return Date()
    }
    
    var kind: MessageKind {
        return .text(text)
    }
}

class MessengerViewController: MessagesViewController {

    // Main body of this screen. Contains the display of the messages in the chat.
    var messages: [MessageTest]
    var member: Member!
    var chatRoom: String!
    
    init(chatName: String) {
        messages = [] //Retrieve all messages during init
        member = Member(name: "Anthony Yang", color: .blue)
        let msg = MessageTest(member: member, text: "Hola", messageId: member.name)
        messages.append(msg)

        super.init(nibName: nil, bundle: nil)
        self.chatRoom = chatName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.chatRoom
        view.backgroundColor = .white
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        let profileButton = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(pushChatInfoViewController))
        self.navigationItem.rightBarButtonItem = profileButton
    }
    
    
    @objc private func pushChatInfoViewController() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
}

extension MessengerViewController: MessagesDataSource {
    
    func currentSender() -> Sender {
        return Sender(id: member.name, displayName: member.name)
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        print(messages.count)
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        let index = indexPath.section
        return messages[index]
    }
        
}

extension MessengerViewController: MessagesLayoutDelegate {
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
    
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 12
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 16
    }
}

extension MessengerViewController: MessagesDisplayDelegate {
    
    /**
     Affects the color of a sender's message, e.g. how messages white or blue on iMessage.
     */
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let msg = messages[indexPath.section]
        let color = msg.member.color
        avatarView.backgroundColor = color
    }
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .darkText
    }
    
}

extension MessengerViewController: MessageInputBarDelegate {

    /**
     Used to create messages when the send button is clicked.
    */
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let newMsg = MessageTest(member: member, text: text, messageId: UUID().uuidString)
        messages.append(newMsg)
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
        print(messages.count)
    }
    
}

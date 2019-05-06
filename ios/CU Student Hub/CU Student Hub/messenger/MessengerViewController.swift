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

struct Message {
    let member: Member
    let text: String
    let messageId: String
    let image: UIImage
}

extension Message: MessageType {
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
    var messages: [Message]
    var member: Member!
    var chatRoom: String!
    
    var refreshTimer: Timer!
    
    init(chatName: String) {
        
        if let name = System.name {
            messages = []
            member = Member(name: name, color: .blue)
        } else {
            fatalError()
        }
        super.init(nibName: nil, bundle: nil)
        self.chatRoom = chatName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Ends the timer from constantly refreshing for messages
        refreshTimer.invalidate()
    }
    
    var firstScroll: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.chatRoom
        view.backgroundColor = .white
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
        messageInputBar.sendButton.setTitleColor(UIColor(red: 0xB3/0xFF, green: 0x1B/0xFF, blue: 0x1B/0xFF, alpha: 1), for: .normal)
        messagesCollectionView.messagesDisplayDelegate = self
        
        // Recent messages will be added to the array.
        // Refreshes for messages every second.
        getRecentMessages()
        refreshTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getRecentMessages), userInfo: nil, repeats: true)
        scrollsToBottomOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
    }
    
    @objc private func getRecentMessages() {
        if let title = self.title {
            let chatname = title.replacingOccurrences(of: " ", with: "_")
            NetworkManager.getMessageData(at: chatname) { posts in
                let recentMSG = posts.map({ post -> Message in
                    let member = Member(name: post.username, color: .white)
                    let message = Message(member: member, text: post.text, messageId: UUID().uuidString, image: UIImage())
                    return message
                })
                DispatchQueue.main.async {
                    self.messages = recentMSG
                    self.messagesCollectionView.reloadData()
                    if self.firstScroll {
                        self.messagesCollectionView.scrollToBottom()
                        self.firstScroll.toggle()
                    }
                }
            }
        } else {
            fatalError()
        }
    }
    
    private func postChatMessage(text: String) {
        if let title = self.title, let netid = System.currentUser {
            let chatname = title.replacingOccurrences(of: " ", with: "_")
            NetworkManager.postMessage(at: chatname, text: text, by: netid) {
                print("Successfully posted message")
            }
        } else {
            fatalError()
        }
    }
}

extension MessengerViewController: MessagesDataSource {
    func currentSender() -> Sender {
        return Sender(id: member.name, displayName: member.name)
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
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
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(
            string: name,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0, alpha: 1)
            ]
        )
    }
    
}

extension MessengerViewController: MessagesDisplayDelegate {
    
    /**
     Affects the color of a sender's message, e.g. how messages white or blue on iMessage.
     */
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let msg = messages[indexPath.section]
        avatarView.initials = String(msg.member.name.prefix(1))
    }
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 55, height: 55)
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .darkText
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor(red: 0xB3/0xFF, green: 0x1B/0xFF, blue: 0x1B/0xFF, alpha: 1) : UIColor(white: 0.86, alpha: 1)
    }
    
}

extension MessengerViewController: MessageInputBarDelegate {
    
    /**
     Used to create messages when the send button is clicked.
     */
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let newMsg = Message(member: member, text: text, messageId: UUID().uuidString, image: System.userProfilePic!)
        messages.append(newMsg)
        inputBar.inputTextView.text = ""
        postChatMessage(text: newMsg.text)
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
}

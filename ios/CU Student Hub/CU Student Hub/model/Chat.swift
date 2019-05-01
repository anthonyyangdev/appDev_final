
import Foundation

class Chat {
    
    var id: String
    var friend: String
    var messages: [MessageModel]
    
    init(id: String, friend: String, messages: [MessageModel]) {
        self.id = id
        self.friend = friend
        self.messages = messages
    }
    
    func mostRecentMessage() -> MessageModel? {
        return messages.last
    }
    
}

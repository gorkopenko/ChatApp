//
//  Constants.swift
//  123
//
//  Created by Gorkopenko Sergey on 04.03.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

struct K {
    static let appName = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LogInToChat"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
        static let imageUrl = "imageUrl"
    }
}

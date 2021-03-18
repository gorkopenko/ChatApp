//
//  MessageCell.swift
//  123
//
//  Created by Gorkopenko Sergey on 03.03.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var viewLabel: UIView!
    @IBOutlet weak var rightImage: UIView!
    @IBOutlet weak var leftImage: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userName2: UILabel!
    @IBOutlet weak var messageImageView: UIImageView!
    
    func configure(imageUrl: URL?, completion: (() -> Void)? = nil) {
        guard let imageUrl = imageUrl else {
            messageImageView.isHidden = true
            return
        }
        messageImageView.isHidden = false
        messageImageView.kf.setImage(with: imageUrl)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageImageView.isHidden = false
        messageImageView.image = nil
    }
    
}

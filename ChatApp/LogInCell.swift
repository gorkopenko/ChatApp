//
//  LogInCell.swift
//  123
//
//  Created by Gorkopenko Sergey on 05.02.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit

class LogInCell: UITextField {
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.white.cgColor
    }

    
}

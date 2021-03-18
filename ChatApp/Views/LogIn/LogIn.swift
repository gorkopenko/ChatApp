//
//  LogIn.swift
//  123
//
//  Created by Gorkopenko Sergey on 08.02.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit

class LogIn: UINibView {
    
    var text: String? {logInTextField.text!}
    
    @IBOutlet weak var logInTextField: UITextField!
    override func commonInit() {
           super.commonInit()
           let yourColor : UIColor = UIColor( red: 73/255, green: 80/255, blue: 87/255, alpha: 1 )
           self.logInTextField.layer.borderWidth = 0.5
           self.logInTextField.layer.borderColor = yourColor.cgColor
       }
}

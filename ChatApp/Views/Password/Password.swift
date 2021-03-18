//
//  Password.swift
//  123
//
//  Created by Gorkopenko Sergey on 05.02.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit

class Password: UINibView {
    
    var text: String? {textFieldOutlet.text}

    
    @IBAction func hideButton(_ sender: UIButton) {
        if isButtonHidden == true {
            hideButtonOutlet.setImage(UIImage(named: "Union-1"), for: .normal)
            textFieldOutlet.isSecureTextEntry = false
        } else {
            hideButtonOutlet.setImage(UIImage(named: "Union"), for: .normal)
            textFieldOutlet.isSecureTextEntry = true

        }
        isButtonHidden.toggle()
    }
    
    @IBOutlet weak var hideButtonOutlet: UIButton!
    
    var isButtonHidden = true
    
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    override func commonInit() {
        super.commonInit()
        let yourColor : UIColor = UIColor( r: 73, g: 80, b: 87)
        self.textFieldOutlet.layer.borderWidth = 0.5
        self.textFieldOutlet.layer.borderColor = yourColor.cgColor
    }
}


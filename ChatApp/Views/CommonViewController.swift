//
//  CommonViewController.swift
//  123
//
//  Created by Danil Vassyakin on 3/16/21.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.numberOfTapsRequired = 1
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

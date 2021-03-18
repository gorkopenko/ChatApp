//
//  RegistrationViewController.swift
//  123
//
//  Created by Gorkopenko Sergey on 25.02.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegistrationViewController: CommonViewController {
    
    @IBOutlet weak var emailTextField: LogIn!
    
    @IBOutlet weak var passwordTextField: Password!
    
    @IBOutlet weak var logInButton2Outlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientColor1 = UIColor( r: 92, g: 60, b: 221 )
        let gradientColor2 = UIColor( r: 94, g: 129, b: 244 )
        logInButton2Outlet.applyGradient(colours: [gradientColor1, gradientColor2])
        logInButton2Outlet.layer.cornerRadius = 5
        logInButton2Outlet.clipsToBounds = true
    }
    
    @IBAction func logInButtonDidPress(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        SVProgressHUD.show(withStatus: "Загрузка")
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            SVProgressHUD.dismiss()
            
            if let error = error {
                print(error)
                let alert = UIAlertController(title: "Ошибка!", message: "Введен неверный логин или пароль.", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: K.registerSegue, sender: self)
            }
        }
        
    }

}

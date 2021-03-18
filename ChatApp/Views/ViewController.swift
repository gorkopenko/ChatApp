//
//  ViewController.swift
//  123
//
//  Created by Gorkopenko Sergey on 03.02.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ViewController: CommonViewController {
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var loginTextField: LogIn!
    @IBOutlet weak var passwordTextField: Password!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientColor1 = UIColor( r: 92, g: 60, b: 221 )
        let gradientColor2 = UIColor( r: 94, g: 129, b: 244 )
        logInButton.applyGradient(colours: [gradientColor1, gradientColor2])
        logInButton.layer.cornerRadius = 5
        logInButton.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        guard let email = loginTextField.text, let password = passwordTextField.text else { return }

        SVProgressHUD.show(withStatus: "Загрузка")
                
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Ошибка!", message: "Введен неверный логин или пароль.", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            } else {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: K.loginSegue, sender: self)
            }
        }
    }

}




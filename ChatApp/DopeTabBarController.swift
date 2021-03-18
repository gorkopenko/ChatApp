//
//  DopeTabBarController.swift
//  123
//
//  Created by Gorkopenko Sergey on 09.02.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit

class DopeTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = generateNavController(vc: ViewController(), title: "First")
        
        UINavigationBar.appearance().prefersLargeTitles = true
        viewControllers = [nav]
        
    }
    
    fileprivate func generateNavController(vc: UIViewController, title: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        return navController
    }
}

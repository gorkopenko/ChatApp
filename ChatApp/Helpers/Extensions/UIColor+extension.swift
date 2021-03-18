//
//  UIColor+extension.swift
//  123
//
//  Created by Gorkopenko Sergey on 08.02.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
}

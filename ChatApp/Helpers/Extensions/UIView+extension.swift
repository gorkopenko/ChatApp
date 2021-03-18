//
//  UIView+extension.swift
//  123
//
//  Created by Gorkopenko Sergey on 08.02.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit
extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        //gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

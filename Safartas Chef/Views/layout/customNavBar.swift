//
//  customNavBar.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/13/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import Foundation
import UIKit


let COLOR_TOP =  "#f1744c"
let COLOR_BOTTOM = "#ee4f4b"

class customView : UIView{
    override init(frame: CGRect) {
        super.init(frame: CGRect())
   
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setGradientBackground(colorTop: UIColor(hexString: COLOR_TOP) , colorBottom: UIColor(hexString: COLOR_BOTTOM))
    }
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
  
}

extension UIView {
    func setGradientBackgroundCircle(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = gradientLayer.frame.size.width / 2
        layer.insertSublayer(gradientLayer, at: 0)
}
}

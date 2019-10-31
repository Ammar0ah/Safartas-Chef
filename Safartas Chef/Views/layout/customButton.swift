//
//  customButton.swift
//  JaberCauseway
//
//  Created by Ammar Al-Helali on 8/10/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class customButton : UIButton {

    func setup(){
       self.roundCorners(corners: [.allCorners], radius: self.frame.size.width / 2 )
    }
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    @IBInspectable var adjustsTitleFontSizeToFitWidth: Bool = false {
        didSet {
            
            self.titleLabel?.adjustsFontSizeToFitWidth = adjustsTitleFontSizeToFitWidth
        }
    }
    
}
extension UIButton {
   
    
}

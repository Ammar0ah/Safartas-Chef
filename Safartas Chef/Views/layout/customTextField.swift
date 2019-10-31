//
//  customTextField.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/10/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import Foundation
import UIKit
import Material
@IBDesignable
class customTextField :TextField{
    let boxColor = "#f27f6e"
    let selectedBoxColor = "#f49170"
    func setup(){
        self.dividerActiveColor = UIColor(hexString: boxColor)
        self.placeHolderColor = UIColor(hexString: boxColor)
        self.placeholderActiveColor = UIColor(hexString: selectedBoxColor)
        self.detailColor = .red
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override init(frame:CGRect){
        super.init(frame: CGRect())
    }
}

extension UITextField{
    func isValidInputs(textFields :[TextField]) ->Bool{
        var result = true
        for field in textFields {
            if field.text!.isEmpty{
                field.detail = "This Field is required!"
                field.detailColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                result = false
            }
           // result =  field.becomeFirstResponder()
        }
        return result
    }
}

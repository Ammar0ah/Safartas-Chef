//
//  ViewController.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/10/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit
import Material
import AVFoundation
import SVProgressHUD

class ChooseLangViewController: UIViewController {
    let textfield = TextField()
    
   let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setDefaultStyle(.dark)
        if defaults.string(forKey: "signed") != nil{
              self.performSegue(withIdentifier: "sliderToMenu", sender: self)
        }
      else if defaults.string(forKey: "slider") != nil {
            self.performSegue(withIdentifier: "sliderToLogin", sender: self)
        }
    }

  
    override func viewWillAppear(_ animated: Bool) {
   
        let colors: [UIColor] = [UIColor(hexString: "#f1744c"), UIColor(hexString: "#ee4f4b")]
        navigationController?.navigationBar.setGradientBackground(colors: colors)
    }
    @IBAction func arabicBtn(_ sender: Any) {
        defaults.set("arabic", forKey: "ar")
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
          self.navigationController?.view.semanticContentAttribute = .forceRightToLeft
       
    }
}


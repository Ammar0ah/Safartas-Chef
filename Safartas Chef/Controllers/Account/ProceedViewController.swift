//
//  ProceedViewController.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/13/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit

class ProceedViewController: UIViewController {
    var chef : Chef!
    @IBOutlet var pinTxt: customTextField!
    @IBOutlet var proceedBtn: customButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        pinTxt.text = pinTxt.text?.localized()
        proceedBtn.setTitle(proceedBtn.titleLabel?.text?.localized(), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func proceedBtnPressedd(_ sender: Any) {
        if pinTxt.isEmpty{
            pinTxt.detail = "PIN Code is required"
        }else {
        chef.params["ChefPINCode"] = pinTxt.text
        chef.params["ChefFCMID"] = ""
            
        chef.registerChef { passed in
            if !passed {
                self.dismiss(animated: true)
            } else {
                
                self.performSegue(withIdentifier: "registerSegue", sender: self)
            }
            
        }
        }
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension ProceedViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

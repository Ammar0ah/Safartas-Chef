//
//  NewPasswordViewController.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/13/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit

class NewPasswordViewController: UIViewController {
    var chef = Chef()
    var mobileNum : String!
    @IBOutlet var newPwd: customTextField!
    @IBOutlet var newPwdAgain: customTextField!
    @IBOutlet var pinCode: customTextField!
    var tempTextFiled : customTextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tempTextFiled = customTextField()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        view.addGestureRecognizer(gesture)
        // Do any additional setup after loading the view.
    }
    func localizeArabic(){
        newPwd.text = newPwd.text!.localized()
         newPwdAgain.text = newPwdAgain.text!.localized()
        pinCode.text = pinCode.text!.localized()
    }
    
    @IBAction func proceedTapped(_ sender: Any) {
        chef.params["ChefNewPassword"] = newPwd.text
        chef.params["ChefPINCode"] = pinCode.text
        chef.params["ChefPhone"] = mobileNum
        print(chef.params)
        chef.forgotPassword { (passed) in
            if !passed{
                self.navigationController?.popViewController(animated: true)
            } else {
                self.performSegue(withIdentifier: "forgotProceedSegue", sender: self)
            }
        }
    }
    
    @objc func screenTapped(){
        tempTextFiled.endEditing(true)
    }
    
}
extension NewPasswordViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tempTextFiled = textField as? customTextField
    }
}

//
//  LoginViewController.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/11/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {
    let defaults = UserDefaults.standard
    var chef = Chef()
    var checked = true
    @IBOutlet var mobileTxtField: customTextField!
    @IBOutlet var pwdTxtField: customTextField!
    var tempTxtField: customTextField!
   
    @IBOutlet var forgotPasswordBtn: UIButton!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var goToLoginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if ISARABIC{
              self.navigationController?.view.semanticContentAttribute = .forceRightToLeft
        }
        tempTxtField = customTextField()
        defaults.set("SliderPassed", forKey: "slider")
        navigationController?.navigationBar.setGradientBackground(colors: [#colorLiteral(red: 0.9450980392, green: 0.4549019608, blue: 0.2980392157, alpha: 1),#colorLiteral(red: 0.9333333333, green: 0.3098039216, blue: 0.2941176471, alpha: 1)])
//        if  defaults.string(forKey: "signed") != nil{
//            self.performSegue(withIdentifier: "loginToMenu", sender: self)
//        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        view.addGestureRecognizer(gesture)
        localizedArabic()
        if let _ = defaults.string(forKey: "ar"){
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
                     self.navigationController?.view.semanticContentAttribute = .forceRightToLeft
        }
    }
    func localizedArabic(){
        mobileTxtField.placeholder = mobileTxtField.placeholder?.localized();
        pwdTxtField.placeholder = pwdTxtField.placeholder?.localized()
        
        loginBtn.setTitle(loginBtn.titleLabel?.text?.localized(), for: .normal)
        goToLoginBtn.setTitle(goToLoginBtn.titleLabel?.text?.localized(), for: .normal); forgotPasswordBtn.setTitle(forgotPasswordBtn.titleLabel?.text?.localized(), for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    @IBAction func loginClicked(_ sender: Any) {
       
        checked = true
        mobileTxtField.detail = ""
        pwdTxtField.detail = ""
        
        if mobileTxtField.isEmpty{
            mobileTxtField.detail = "Mobile Number is required"
            checked = false
        }
        if mobileTxtField.text!.count != 11 {
               mobileTxtField.detail = "Mobile Number must be 11 digits"
            checked = false
        }
       
        if pwdTxtField.isEmpty {
            pwdTxtField.detail = "Password is required"
            checked = false
        }
        
        chef.params["ChefFCMID"] = ""
        chef.params["ChefPhone"] = mobileTxtField.text
        chef.params["ChefPassword"] = pwdTxtField.text
        print(chef.params)
        if checked{
            chef.loginChef {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
        }
       
    }
    
     @IBAction func forgetPwdPressed(_ sender: Any) {
        SVProgressHUD.show()
        chef.params["UserPhone"] = mobileTxtField.text!
        print(chef.params)
        chef.sendPinCode {  
            SVProgressHUD.dismiss()
            self.performSegue(withIdentifier: "forgotSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forgotSegue"{
            if let vc = segue.destination as? NewPasswordViewController{
                vc.mobileNum = mobileTxtField.text
            }
        }
    }
    
    @objc func screenTapped(){
        tempTxtField.endEditing(true)
    }
    
}
extension LoginViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tempTxtField = textField as? customTextField
        if let txtField = textField as? customTextField{
            txtField.detail = ""
        }
   
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

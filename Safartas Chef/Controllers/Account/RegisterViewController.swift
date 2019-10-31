//
//  RegisterViewController.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/10/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreLocation



class RegisterViewController: UIViewController ,LocationsListDelegate {
 
    
    var chef : Chef
    var checked = true
    let locationManager = CLLocationManager()
    var location = ""
    required init?(coder aDecoder: NSCoder) {
        chef = Chef()
        super.init(coder: aDecoder)
    }
    var tempTxtField : customTextField!
    @IBOutlet var nameTxtField: customTextField!
    @IBOutlet var mobileTxtField: customTextField!
    @IBOutlet var pwdTxtField: customTextField!
    @IBOutlet var pwdAgainTxtField: customTextField!
    @IBOutlet var currentLocationLbl: UILabel!
    @IBOutlet var signUpBtn: UIButton!
    
    @IBOutlet var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tempTxtField = customTextField()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        view.addGestureRecognizer(gesture)
        // Do any additional setup after loading the view.
        localizeArabic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
  
    }
    func localizeArabic(){
        nameTxtField.placeholder = nameTxtField.placeholder?.localized()
        pwdTxtField.placeholder = pwdTxtField.placeholder?.localized()
        mobileTxtField.placeholder = mobileTxtField.placeholder?.localized()
        pwdAgainTxtField.placeholder = pwdAgainTxtField.placeholder?.localized()
        loginBtn.setTitle(loginBtn.titleLabel?.text?.localized(), for: .normal); signUpBtn.setTitle(signUpBtn.titleLabel?.text?.localized(), for: .normal)
        
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
      self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    @IBAction func registerClicked(_ sender: Any) {
        nameTxtField.detail = ""
         pwdTxtField.detail = ""
        mobileTxtField.detail = ""
        pwdAgainTxtField.detail = ""
        checked = true
        if nameTxtField.text!.isEmpty{
            nameTxtField.detail = "This field is required"
            checked = false
        }
        if pwdTxtField.text!.isEmpty{
            pwdTxtField.detail = "This field is required"
             checked = false
        }
        if pwdTxtField.text!.count < 8 {
            pwdTxtField.detail = "Password must be 8 characters at least"
             checked = false
        }
        if mobileTxtField.text!.isEmpty{
            mobileTxtField.detail = "This field is required"
             checked = false
        }
        if  mobileTxtField.text!.count != 11 {
            mobileTxtField.detail = "Mobile Number must be 11 digits"
             checked = false
        }
        if pwdAgainTxtField.text!.isEmpty{
            pwdAgainTxtField.detail = "This field is required"
             checked = false
        }
        
        if location.isEmpty{
            SVProgressHUD.showError(withStatus: "Select a location")
            SVProgressHUD.dismiss(withDelay: 1.5)
             checked = false
        }
        if checked {
            chef.params["ChefName"] = nameTxtField.text ?? ""
            chef.params["ChefPhone"] = mobileTxtField.text ?? ""
            chef.params["UserPhone"] = mobileTxtField.text ?? ""
            chef.params["ChefPassword"] = pwdTxtField.text ?? ""
            chef.sendPinCode {
                self.performSegue(withIdentifier: "pincodeSegue", sender: self)
            }
          
        }
  

     //   self.performSegue(withIdentifier: "registerSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue"{
            if let vc = segue.destination as? LocationTableViewController{
              
                    vc.chef = self.chef
                    vc.delegate = self
                vc.tempLocations = self.chef.location.Locations
            }
        }
        else if segue.identifier == "pincodeSegue"{
            if let vc = segue.destination as? ProceedViewController{
               vc.chef = self.chef
            }
        }
        }
   
    @IBAction func locationBtn(_ sender: Any) {
        chef.getlocations {
            
           self.performSegue(withIdentifier: "searchSegue", sender: self)

        }
    }
    
    //Mark:- Locations list
    func getLocationBack(locationObj: LocationObj) {
        location = locationObj.LocationName
        chef.params["ChefAreaID"] = locationObj.LocationID
        print(chef.params)
        currentLocationLbl.text = locationObj.LocationName
    }
    @objc func screenTapped(){
        tempTxtField.endEditing(true)
    
    }
}
/// Mark:- Location manager

extension RegisterViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            self.locationManager.stopUpdatingLocation()
            print(location.coordinate.latitude , location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            print(latitude)
            chef.params["ChefLatitude"] = latitude
            chef.params["ChefLongitude"] = longitude
  
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

        SVProgressHUD.showError(withStatus: "Couldn't get location")
        SVProgressHUD.dismiss(withDelay: 1)
    }
}
extension RegisterViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
     tempTxtField = textField as? customTextField
        let txtField = textField as! customTextField
        txtField.detail = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
        if textField == pwdAgainTxtField{
       
        if textField.text != pwdTxtField.text {
            pwdAgainTxtField.detailLabel.text = "Passwords aren't identical"
            pwdAgainTxtField.detailColor = .red
        }
        else {
            pwdAgainTxtField.detailLabel.isHidden = true
        }
    }
        
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//
//  AddMealViewController.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/18/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit
import DropDown
import Material
import SVProgressHUD
import SDWebImage

protocol DismissAllDelegate {
    func dismissAll()
}
class AddMealViewController: UIViewController {
    var id = ""
    var meal : Meal!
    var menu = Menu()
    var food = Food()
    let dropDown : DropDown = DropDown()
    @IBOutlet var sliderView: UIView!
    @IBOutlet var mealImageBtn: FlatButton!
    @IBOutlet var mealNameTxt: TextView!
    @IBOutlet var selectDishBtn: FlatButton!
    @IBOutlet var timeTxt: TextField!
    @IBOutlet var enoughForTxt: TextField!
    @IBOutlet var priceTxt: TextField!
    @IBOutlet var descTxt: TextView!
    var tempTxtField : UITextField! = UITextField()
    var tempTxtView : UITextView! = UITextView()
    let imagePicker = UIImagePickerController()
    var items = [String]()
    var delegate : RefreshPageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        imagePicker.delegate = self
     
        if let meal = self.meal {
            // editing meal
            print(meal)
            if let _ = defaults.string(forKey: "image"){ mealImageBtn.sd_setImage(with: URL(string: meal.MealPicPath), for: .normal, completed: nil)
            }else {
                mealImageBtn.setImage(UIImage(named: "add_photo"), for: .normal)
            }
            mealNameTxt.text = meal.MealName
            
            timeTxt.text = meal.MealPreparTime
            enoughForTxt.text = meal.MealEnoughToPeople
            priceTxt.text = meal.MealPrice
            descTxt.text = meal.MealDesc
        } else {
            // Adding a new meal
            food.params["MealAppOptID"] = id
            food.params["MealID"] = ""
        }
        mealImageBtn.roundCorners(corners: [.allCorners], radius: 10)
        menu.getMenuTypes {
            SVProgressHUD.dismiss()
            for item in self.menu.menuItems{
                self.dropDown.dataSource.append(item.MenuName)
            }
            self.selectDishBtn.setTitle(self.dropDown.dataSource[0], for: .normal)
            self.food.params["MealMenuID"] = self.menu.menuItems[0].MenuID
            
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        self.view.addGestureRecognizer(gesture)
        dropDown.anchorView = sliderView
        
        dropDown.width = 100
        selectDishBtn.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        
    }
 
    //MARK:- gesture
    func localizeArabic(){
        descTxt.text = descTxt.text.localized()
        selectDishBtn.setTitle(selectDishBtn.title!.localized(), for: .normal)
    }
    
    @objc func screenTapped(){
        tempTxtField.endEditing(true)
        tempTxtView.endEditing(true)
    }
    
    //MARK:- add image
    @IBAction func addImagePressed(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        present(imagePicker, animated: true, completion: nil)
        
    }
    //MARK: DropDown
    @IBAction func dropDownSelected(_ sender: Any) {
        dropDown.show()
        dropDown.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.food.params["MealMenuID"] = self.menu.menuItems[index].MenuID
            self.selectDishBtn.setTitle(item, for: .normal)
        }
    }
    
    //MARK:- Save and finish
    @IBAction func savePressed(_ sender: UIButton) {
        if timeTxt.validateInput(fields: [enoughForTxt,timeTxt,priceTxt,timeTxt]){
            food.params["MealChefID"] = defaults.string(forKey: "_id")
            food.params["MealDesc"] = descTxt.text
            food.params["MealEnoughToPeople"] = (enoughForTxt.text! as NSString).floatValue
            food.params["MealName"] = mealNameTxt.text
            food.params["MealPreparTime"] = (timeTxt.text! as NSString).floatValue
            food.params["MealPrice"] = (priceTxt.text! as NSString).floatValue
            if let image = self.mealImageBtn.image(for:.normal){
                food.addEditMeal {
                    //self.food.meals = []
                    
                    self.food.uploadMealImage(image: image){
                        self.dismiss(animated: true)
                    
                    }
                }
            } else {
                SVProgressHUD.showError(withStatus: "Please pick an Image")
            }
      
       
       
              
        }
       // delegate?.getChefMenu()
    }
    
    
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension AddMealViewController : UITextFieldDelegate ,UITextViewDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tempTxtField = textField
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tempTxtField = textField
        textField.resignFirstResponder()
        return false
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        tempTxtView = textView
    }
}

extension AddMealViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
            
        }
        mealImageBtn.setImage(image, for: .normal)
        dismiss(animated: true)
        
    }
}

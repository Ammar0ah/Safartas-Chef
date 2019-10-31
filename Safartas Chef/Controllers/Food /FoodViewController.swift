//
//  FoodViewController.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/15/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit
import SDWebImage
import PWSwitch


protocol MealDelegate {
    func getMeal(myData dataobject: AnyObject,id:String)
    func chefDeleteMeal(id:String)
}
protocol RefreshPageDelegate{
    func getChefMenu()
}
class FoodViewController: UIViewController ,MealDelegate,RefreshPageDelegate ,switchDelegate{
    
    let refreshControl = UIRefreshControl();
    
    var mealID = ""
    var food : Food = Food()
    var sender = ""
    var meals = [Meal]()
    @IBOutlet var addMealBtn: UIButton!
    @IBOutlet var imageHolder: UIView!
    @IBOutlet var foodTableView: UITableView!
    @IBOutlet var profileBtn: UIButton!
    var delegate : DismissAllDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        foodTableView.bounces = false
        foodTableView.rowHeight = 120
        // Do any additional setup after loading the view.
        
        if sender == "editMenu"{
            foodTableView.register(UINib(nibName:"FoodTableViewCell",bundle: nil), forCellReuseIdentifier: "foodCell")
            
        }
        else {
            foodTableView.register(UINib(nibName:"ActiveTableViewCell",bundle: nil), forCellReuseIdentifier: "activeCell")
            addMealBtn.isHidden = true
        }
           getChefMenu()
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .allEvents)
        foodTableView.refreshControl = refreshControl
        
    }
    @objc func refreshAction(){
        getChefMenu()
    }
    override func viewWillLayoutSubviews() {
        imageHolder.setGradientBackgroundCircle(colorTop: UIColor(hexString:COLOR_TOP), colorBottom: UIColor(hexString: COLOR_BOTTOM))
        if let image = defaults.string(forKey: "image"){
        profileBtn.sd_setBackgroundImage(with: URL(string:image), for: .normal, completed: nil)
        }
        profileBtn.roundCorners(corners: [.allCorners], radius: profileBtn.frame.width / 2)
    }

    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated:true)
    }
    // Mark: Meals Delegate
    func getMeal(myData dataobject: AnyObject,id:String) {
        
        mealID = id
        food.params["MealID"] = id
        food.getMealInfo(){
            self.performSegue(withIdentifier: "editItemSegue", sender: dataobject)
        }
    }
    @IBAction func homeClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
        delegate?.dismissAll()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editItemSegue" {
            if let vc = segue.destination as? AddMealViewController{
                vc.food = self.food
                vc.meal = self.food.meal
                vc.menu.params = self.food.params
                vc.delegate = self
                
            }
        }
        else if  segue.identifier == "addItemSegue" {
            if let vc = segue.destination as? AddMealViewController , let optID = self.food.params["AppOptID"] as? String {
                vc.id = optID
                vc.delegate = self
            }
        }
        
    }
    // MARK: delete meal
    func chefDeleteMeal(id:String) {
        
        food.params["MealID"] = id
        food.deleteMeal {
            self.food.meals = []
            self.food.getChefMenu(completion: {
                self.foodTableView.reloadData()
            })
        }
    }
    // MARK: refresh delegate
    func getChefMenu() {
           meals = []
              food.getChefMenu {
            self.foodTableView.reloadData()
        }
    }
    //MARK: Switch Delegate
    func switchStatus(index: IndexPath,pwswitch: PWSwitch) {
        
        food.switchBool[index.row] = !pwswitch.on
    
    }
    @IBAction func homeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}




extension FoodViewController : UITableViewDelegate ,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return food.meals.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let meal = food.meals[indexPath.row]
        if sender == "editMenu"{
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as? FoodTableViewCell else{return  UITableViewCell()}
            
            cell.mealNameLbl.text = meal.MealName
            cell.timeLbl.text = meal.MealPreparTime
            cell.personsNumLbl.text = meal.MealEnoughToPeople
            cell.priceLbl.text = "\(meal.MealPrice) $"
            cell.mealImage.sd_setImage(with: URL(string: meal.MealPicPath ), completed: nil)
            cell.delegate = self
            cell.id = meal.MealID
            cell.pendingImg.isHidden = !food.statusBool[indexPath.row]
            if food.mealStatus[indexPath.row] == "0"{
                cell.pendingImg.isHidden = false
            }
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "activeCell", for: indexPath) as? ActiveTableViewCell else{return  UITableViewCell()}
            
            cell.pwSwitch.setOn(!food.switchBool[indexPath.row], animated: true)
            if  cell.pwSwitch.on{
                cell.activateLbl.textColor = #colorLiteral(red: 0.9891273379, green: 0.5505148768, blue: 0.1967552006, alpha: 1)
                cell.activateLbl.text = "ON"
            } else {
                cell.activateLbl.textColor = .black
                cell.activateLbl.text = "OFF"
            }
            cell.delegate = self
            cell.mealNameLbl.text = meal.MealName
            cell.timeLbl.text = meal.MealPreparTime
            cell.personsNumLbl.text = meal.MealEnoughToPeople
            cell.priceLbl.text = "\(meal.MealPrice) $"
            cell.mealImage.sd_setImage(with: URL(string: meal.MealPicPath ), completed: nil)
           // cell.delegate = self
      //      cell.id = meal.MealID
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    
}

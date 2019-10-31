//
//  MenuViewController.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/13/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit
import Material
import SDWebImage

class MenuViewController: UIViewController {
    let defaults = UserDefaults.standard
    let menu = Menu()
    let food = Food()
    @IBOutlet var logoutBtn: FlatButton!
    @IBOutlet var image: UIImageView!
    @IBOutlet var ProfileBtn: UIButton!
    @IBOutlet var ordersBtn: UIButton!
    @IBOutlet var ordersView: UIView!
    @IBOutlet var ordersLabel: UILabel!
    @IBOutlet var ordersSubView: UIView!
     ////////////////// Edit //////////
    @IBOutlet var editView: UIView!
    @IBOutlet var editLabel: UILabel!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var editSubView: UIView!
    ////////////////// active /////////
    @IBOutlet var activeBtn: UIButton!
    @IBOutlet var activeLabel: UILabel!
    @IBOutlet var activeSubView: UIView!
    @IBOutlet var activeView: UIView!
    
    /////////////////about ////////
    @IBOutlet var aboutBtn: UIButton!
    @IBOutlet var aboutView: UIView!
    @IBOutlet var aboutSubView: UIView!
    @IBOutlet var aboutLabel: UILabel!
    
    @IBOutlet var imageHolder: UIView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersBtn.imageEdgeInsets = UIEdgeInsets(top:200, left: 0, bottom: 0, right: 50)
        if let image =  defaults.string(forKey: "image"){
             let url = URL(string: image)
       print(image)
              ProfileBtn.sd_setBackgroundImage(with: url, for: .normal, completed: nil)
            if let _ = defaults.string(forKey: "ar"){
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                         self.navigationController?.view.semanticContentAttribute = .forceRightToLeft
            }
        }
  
   
        
      
        logoutBtn.setTitle(logoutBtn.title?.localized(), for: .normal)
        // Do any additional setup after loading the view.
    }
   
    override func viewWillAppear(_ animated: Bool) {
        ProfileBtn.roundCorners(corners: [.allCorners], radius: ProfileBtn.frame.size.width / 2 )
        setupViewsColors()
        imageHolder.layer.cornerRadius = imageHolder.frame.size.width / 2
        self.modalPresentationStyle = .overFullScreen
    }
    
    
    @IBAction func editTouched(_ sender: Any) {
     
        print(menu.params)
        menu.getChefAppOptions(){
            self.performSegue(withIdentifier: "editMenuSegue", sender: self)
        }
 }
    
    ///MARK :- Corner Radius with gradient
    override func viewDidLayoutSubviews() {
        ordersView.layer.cornerRadius = 5
        ordersSubView.roundCorners(corners: [.bottomLeft , .bottomRight], radius: 10)
        editView.layer.cornerRadius = 5
        editSubView.roundCorners(corners: [.bottomLeft , .bottomRight], radius: 10)
        activeView.layer.cornerRadius = 5
        activeSubView.roundCorners(corners: [.bottomLeft , .bottomRight], radius: 10)
        aboutView.layer.cornerRadius = 5
        aboutSubView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
       
        imageHolder.setGradientBackgroundCircle(colorTop: UIColor(hexString: COLOR_TOP) , colorBottom: UIColor(hexString: COLOR_BOTTOM))
    }
    //MARK:
    @IBAction func ordersTapped(_ sender: Any) {
       
//        ordersLabel.textColor = .white
//        ordersSubView.backgroundColor = UIColor(hexString: "#f49170")
//        editLabel.textColor = .white
//        editSubView.backgroundColor = UIColor(hexString: "#f49170")
//        print("got event")
    }
  
 
    @IBAction func logoutClicked(_ sender: Any) {
  self.dismiss(animated: true)
    }
    
    @IBAction func activeClicked(_ sender: Any) {
       
            self.performSegue(withIdentifier: "activeSegue", sender: self)
    }
    // MARK:- SETUP COLORS
    func setupViewsColors(){
        ordersLabel.textColor = .black
        ordersSubView.backgroundColor = UIColor(hexString: "#E5E5E5")
        editLabel.textColor = .black
        editSubView.backgroundColor = UIColor(hexString: "#E5E5E5")
        activeLabel.textColor = .black
        activeSubView.backgroundColor = UIColor(hexString: "#E5E5E5")
        aboutLabel.textColor = .black
        aboutSubView.backgroundColor =  UIColor(hexString: "#E5E5E5")
        }
    
    
    
    //MARK: Prepare segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editMenuSegue"{
            if let vc = segue.destination as? EditMenuViewController{
                vc.appOptions = self.menu.appOptions
                
            }
        }
      
    }
}

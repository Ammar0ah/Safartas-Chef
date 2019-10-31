    //
    //  EditMenuViewController.swift
    //  Safartas Chef
    //
    //  Created by Ammar Al-Helali on 9/14/19.
    //  Copyright © 2019 Ammar Al-Helali. All rights reserved.
    //
    
    import UIKit
    import SDWebImage
    
    class EditMenuViewController: UIViewController {
        var appOptions : [AppOptions]!
        
        var food = Food()
        @IBOutlet var imageHolder: UIView!
        @IBOutlet var ItemscollectionView: UICollectionView!
        @IBOutlet var profileBtn: UIButton!
        override func viewDidLoad() {
            super.viewDidLoad()
            imageHolder.setGradientBackgroundCircle(colorTop: UIColor(hexString: COLOR_TOP), colorBottom: UIColor(hexString: COLOR_BOTTOM))
            if let image = defaults.string(forKey: "image"){

                profileBtn.sd_setBackgroundImage(with: URL(string: image), for: .normal, completed: nil)
            }
            
        }
        
        
        @IBAction func backClicked(_ sender: Any) {
            dismiss(animated:true)
            
        }
        
        override func viewWillLayoutSubviews() {
            profileBtn.roundCorners(corners: [.allCorners], radius: profileBtn.frame.width / 2 )
        }
    }
    extension EditMenuViewController : UICollectionViewDelegate , UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return appOptions.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? EditMenuCollectionViewCell {
                let option = appOptions[indexPath.row]
                cell.image?.sd_setImage(with: URL(string: option.AppOptPicPath), completed: nil)
                cell.imageLabel.text = option.AppOptName
                return cell
            }
            return UICollectionViewCell()
            
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            
            let totalCellWidth = 80 * collectionView.numberOfItems(inSection: 0)
            let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
            
            let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
            let rightInset = leftInset
            
            return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            food.params["AppOptID"] = "\(indexPath.row + 1)"
            food.params["MealAppOptID"] = "\(indexPath.row + 1)"
            food.params["ChefAppOptID"] = "\(indexPath.row + 1)"
            food.params["ChefID"] = defaults.string(forKey: "_id")
            //        if ISARABIC {
            //            food.params["Lang"] = "ar"
            //        } else {
            //            food.params["Lang"] = "tr"
            //        }
            
            //    print(food.params)
            food.meals = []
            self.performSegue(withIdentifier: "foodSegue", sender: self)
            
            
        }
        //Mark: prepare for segues
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "foodSegue" {
                if let vc = segue.destination as? FoodViewController{
                    
                    vc.sender = "editMenu"
                    vc.food = food
                    vc.delegate = self
                    
                }
            }
        }
        
        
    }
    extension EditMenuViewController : DismissAllDelegate{
        func dismissAll() {
            self.dismiss(animated: true)
        }
        
        
    }

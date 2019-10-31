//
//  FoodTableViewCell.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/15/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit



class FoodTableViewCell: UITableViewCell {
    var id = ""
    @IBOutlet var timeLbl : UILabel!
    @IBOutlet var mealNameLbl: UILabel!
    @IBOutlet var personsNumLbl: UILabel!
    @IBOutlet var priceLbl: UILabel!
    @IBOutlet var mealImage: UIImageView!
    @IBOutlet var pendingImg: UIImageView!
    var delegate : MealDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        pendingImg.isHidden = true 
        // Initialization code
    }

    @IBAction func deleteClicked(_ sender: UIButton) {
        print(sender.tag)
        delegate?.chefDeleteMeal(id: id)
    }
    @IBAction func editClicked(_ sender: UIButton) {
        delegate?.getMeal(myData: sender,id: id)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  ActiveTableViewCell.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/27/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit
import PWSwitch
protocol switchDelegate {
    func switchStatus(index: IndexPath,pwswitch: PWSwitch)
}
class ActiveTableViewCell: UITableViewCell {
    var pwSwitch : PWSwitch!
    var delegate : switchDelegate?
    
    
    @IBOutlet var activateLbl: UILabel!
    @IBOutlet var mealImage: UIImageView!
    @IBOutlet var priceLbl: UILabel!
    @IBOutlet var personsNumLbl: UILabel!
    @IBOutlet var timeLbl: UILabel!
    @IBOutlet var mealNameLbl: UILabel!
    @IBOutlet var switchView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pwSwitch =  PWSwitch(frame: CGRect(x: 0, y: 0, width: 50, height: 26))
      
        switchView.addSubview(pwSwitch)
        pwSwitch.addTarget(self, action: #selector(self.onSwitchChanged), for: .valueChanged)
    }
    
    @objc func onSwitchChanged(){
        delegate?.switchStatus(index: self.indexPath!,pwswitch: pwSwitch)
        if pwSwitch.on{
            activateLbl.textAlignment = .right
            activateLbl.text = "ON"
            activateLbl.textColor = #colorLiteral(red: 0.9891273379, green: 0.5505148768, blue: 0.1967552006, alpha: 1)
            activateLbl.font = UIFont.boldSystemFont(ofSize: 15)
            
        } else {
            activateLbl.textAlignment = .left
            activateLbl.text = "OFF"
             activateLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            activateLbl.font = UIFont.systemFont(ofSize:14)
            
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

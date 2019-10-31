//
//  EditMenuCollectionViewCell.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/19/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit

class EditMenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var imageLabel: UILabel!
    @IBOutlet var backView: UIView!
    override func awakeFromNib() {
       backView.roundCorners(corners: [.allCorners], radius: 5)
    }
}

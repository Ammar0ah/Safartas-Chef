//
//  LoginViewController.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/10/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit
import ImageSlideshow

class CarouselViewController: UIViewController {
    @IBOutlet var iCarouselView: iCarousel!
    
    let images = [ UIImage(named: "SAFARTASPage_1"),
                   UIImage(named: "SAFARTASPage_2"),
                   UIImage(named: "SAFARTASPage_3"),
                   UIImage(named: "SAFARTASPage_4"),
                ]

    override func viewDidLoad() {
                super.viewDidLoad()
        iCarouselView.type = .linear
        iCarouselView.isPagingEnabled = true
        
    
     
    }
    
    
   override func viewWillAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
          navigationController?.isNavigationBarHidden = false
    }
    
    
}
extension CarouselViewController : iCarouselDelegate,iCarouselDataSource{
   
    func numberOfItems(in carousel: iCarousel) -> Int {
      return images.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let imageView : UIImageView!
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        if index == 3{
            imageView.contentMode = .scaleToFill  
        } else {
            imageView.contentMode = .scaleAspectFill
        }
        
        
        imageView.image = images[index]
        print(index)

        return imageView
        
    }
    func carouselDidEndDragging(_ carousel: iCarousel, willDecelerate decelerate: Bool) {
        if (carousel.currentItemIndex == images.count - 1) {
              self.performSegue(withIdentifier: "RegisterSegue", sender: self)
            
        }
    }
}

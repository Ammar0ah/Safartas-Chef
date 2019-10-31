//
//  OrdersViewController.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 10/3/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit
import ViewPager_Swift
import SDWebImage
class OrdersViewController: UIViewController {
    var historyVC : HistoryTableViewController?
    var bendingVC : BendingTableViewController?
    var currentVC : CurrentTableViewController?
    var viewPager:ViewPager?
    let myOptions = ViewPagerOptions()
    let imgbutton =  UIButton(type: .custom)
  
    @IBOutlet var profileBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileBtn.roundCorners(corners: [.allCorners], radius: profileBtn.frame.width / 2 )
          let colors: [UIColor] = [UIColor(hexString: "#f1744c"), UIColor(hexString: "#ee4f4b")]
     navigationController?.navigationBar.setGradientBackground(colors: colors)
//
//        if #available(iOS 13.0, *) {
//            historyVC = (UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(identifier: "historyVC") as! HistoryTableViewController)
//            bendingVC = (UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(identifier: "bendingVC") as! BendingTableViewController)
//            currentVC = (UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(identifier: "currentVC") as! CurrentTableViewController)
//
//        } else {
            historyVC = (UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "historyVC") as! HistoryTableViewController)
            bendingVC = (UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "bendingVC") as! BendingTableViewController)
            currentVC = (UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "currentVC") as! CurrentTableViewController)
      //  }
        myOptions.tabType = .imageWithText
        myOptions.distribution = .segmented
        myOptions.tabViewBackgroundDefaultColor = #colorLiteral(red: 0.94190377, green: 0.4233814776, blue: 0.3055009544, alpha: 1)
        myOptions.tabIndicatorViewBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        myOptions.tabViewBackgroundHighlightColor = #colorLiteral(red: 0.9294117647, green: 0.3411764706, blue: 0.3019607843, alpha: 1)
        myOptions.isTabHighlightAvailable = true
        myOptions.isTabIndicatorAvailable = true
        
        viewPager = ViewPager(viewController: self)
        viewPager?.setOptions(options: myOptions)
        viewPager?.setDataSource(dataSource: self)
        viewPager?.setDelegate(delegate: self)
        
        viewPager?.build()
        if let image = defaults.string(forKey: "image"){
            profileBtn.sd_setImage(with: URL(string: image)!, for: .normal, completed: nil)
        }
     //   imgbutton.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
    //      imgbutton.backgroundColor = .red
   //     imgbutton.setImage( UIImage(named:"man-user") , for: .normal)
   //       imgbutton.addTarget(self, action: #selector(clickOnButton), for: .touchUpInside)
   //     navigationItem.titleView?.backgroundColor = .clear
     //   navigationItem.titleView = imgbutton
        // myview.addSubview(viewPager)
    }
    @objc func clickOnButton(){
        
    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func homeBtnClicked(_ sender: Any) {
         self.dismiss(animated: true)
        
    }
}
extension OrdersViewController : ViewPagerDelegate {
    func willMoveToControllerAtIndex(index: Int) {
        print("will move to \(index)")
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        print("did move to \(index)")
    }
    
    
}
extension OrdersViewController : ViewPagerDataSource{
    func numberOfPages() -> Int {
        return 3
    }
    
    func viewControllerAtPosition(position: Int) -> UIViewController {
        if position == 0 {
            return historyVC!
        } else if position == 1 {
            return bendingVC!
        } else {
            return currentVC!
        }
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return [ViewPagerTab(title: "History", image: #imageLiteral(resourceName: "history")), ViewPagerTab(title: "Bending", image: #imageLiteral(resourceName: "stopwatch")), ViewPagerTab(title: "Current", image: #imageLiteral(resourceName: "stopwatch2"))]
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
    
    
}

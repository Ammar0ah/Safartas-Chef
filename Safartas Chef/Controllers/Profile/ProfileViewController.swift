//
//  ProfileViewController.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 10/25/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var profileTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row == 0 {
            cell = profileTable.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
            cell.textLabel?.text = "Kaşçı adı".localized()
        } else if indexPath.row == 1 {
              cell = profileTable.dequeueReusableCell(withIdentifier: "workingCell", for: indexPath)
            cell.textLabel?.text = "Çalışma saatleri".localized()
        }else if indexPath.row == 2{
              cell = profileTable.dequeueReusableCell(withIdentifier: "minCell", for: indexPath)
            cell.textLabel?.text = "Minimum sipariş".localized()
        }else if indexPath.row == 3 {
              cell = profileTable.dequeueReusableCell(withIdentifier: "langCell", for: indexPath)
            cell.textLabel?.text = "Dil".localized()
        }
        return cell
    }
    
    
}

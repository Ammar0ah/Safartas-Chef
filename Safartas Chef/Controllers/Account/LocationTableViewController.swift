//
//  LocationTableViewController.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/11/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import UIKit

protocol LocationsListDelegate {
    func getLocationBack(locationObj: LocationObj)
}


class LocationTableViewController: UITableViewController {
    var delegate : LocationsListDelegate?
    var tempLocations = [LocationObj]()
    var chef = Chef()
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
                 self.navigationController?.view.semanticContentAttribute = .forceLeftToRight
       
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        if let _ = defaults.string(forKey: "ar"){
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        self.navigationController?.view.semanticContentAttribute = .forceLeftToRight
        }
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempLocations.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        cell.textLabel?.text = tempLocations[indexPath.row].LocationName
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getLocationBack(locationObj: tempLocations[indexPath.row])
        //        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
// MARK:- Search Bar
extension LocationTableViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(chef.location.Locations)
        if searchText.isEmpty{
            tempLocations = chef.location.Locations
            self.tableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        tempLocations = chef.location.Locations
        var tempSearches = [LocationObj]()
        if let search = searchBar.searchTextField.text?.lowercased() {
            if !search.isEmpty{
         
                tempSearches = tempLocations.filter {
                    
                    return $0.LocationName.lowercased().contains(search)
                    
                    
                }
                print(tempSearches)
                tempLocations = tempSearches
                tableView.reloadData()
                
                
                
            }
            
            searchBar.resignFirstResponder()
        }
    }
}
    extension LocationTableViewController : UITextFieldDelegate{
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}

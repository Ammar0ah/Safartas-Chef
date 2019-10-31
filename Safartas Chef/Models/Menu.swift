//
//  Menu.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/18/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD
import SwiftyJSON


class Menu : Chef {
    var appOptions : [AppOptions]
    var menuItems : [MenuItem]
    override init() {
        appOptions = [AppOptions]()
        menuItems = [MenuItem]()
        super.init()
        params["ChefID"] = defaults.string(forKey: "_id")
    }
    func getChefAppOptions(completion: @escaping () -> ()){
        params["Lang"] = Lang
        SVProgressHUD.show()
        Alamofire.request(getChefAppOptionsURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON {
                response in
                if response.result.isSuccess{
                    let json = JSON(response.result.value!)
                    if json["ResultResponse"].stringValue == "0"{
                        for i in 0..<json["AppOptions"].arrayValue.count{
                            var option = json["AppOptions"][i]
                            self.appOptions.append(
                                AppOptions(AppOptID: option["AppOptID"].stringValue,
                                           AppOptName: option["AppOptName"].stringValue,
                                           AppOptPicPath: option["AppOptPicPath"].stringValue )
                            )
                        }
                        SVProgressHUD.dismiss()
                        completion()
                        self.appOptions = []
                    }
                    else {
                        SVProgressHUD.showError(withStatus: json["Description"].stringValue)
                        SVProgressHUD.dismiss(withDelay: 1.5)
                    }
                }
                else {
                    self.requestFailed()
                }
                
                
        }
    }
    //MARK:- MENU TYPES
    func getMenuTypes(completion: @escaping () -> ()){
        SVProgressHUD.show()
        Alamofire.request(getMenuTypesURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                if response.result.isSuccess{
                    let json = JSON(response.result.value!)
                    if json["ResultResponse"].stringValue == "0" {
                        for item in json["MenuItems"].arrayValue{
                            self.menuItems.append(MenuItem(MenuID: item["MenuID"].stringValue,
                                                           MenuName: item["MenuName"].stringValue))
                        }
                        completion()
                    } else {
                       print("Menu types" , json["Description"].stringValue)
                    }
                }
                else {
                    self.requestFailed()
                }
                
        }
    }
    
}


struct AppOptions{
    var AppOptID : String
    var AppOptName : String
    var AppOptPicPath : String
}

struct MenuItem {
    var MenuID : String
    var MenuName : String
}



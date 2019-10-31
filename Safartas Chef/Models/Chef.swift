//
//  Chef.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/11/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD
import SwiftyJSON
import AlamofireObjectMapper
///# global
let defaults = UserDefaults.standard



class Chef {
    var login : Login!
    var _id : String!
    let device = Device()
    var Lang : String!
    var location : Location!
    var chefPic : String!
    var params = Dictionary<String , Any>()
    var passed = true
    typealias onResponse<T> = (_ response:T) -> Void
    typealias onFailure = (_ message: String) -> Void
    init(){
        params["WsPassword"] = "123"
        params["WsUsername"] = "123"
        params["device"] = device.serializeDevice()
        if ISARABIC{
           Lang = "ar"
        }
        else {
            Lang = "tr"
        }
        params["Lang"] = Lang
        if let id = defaults.string(forKey: "_id"){
            params["MealChefID"] = id
            params["ChefID"] = id
        }
    }
    func getlocations (completion: @escaping () -> ()) {
        SVProgressHUD.show()
        if ISARABIC{
            Lang = "ar"
        } else {
            Lang = "tr"
        }
     //   defaults.set(Lang, forKey: "lang")
        params["Lang"] = Lang
        params["device"] = device.serializeDevice()
        Alamofire.request(getlocationsURL, method: .post
            , parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON {
                response in
                if response.result.isSuccess{
                    
                    SVProgressHUD.dismiss()
                    do {
                        self.location = try JSONDecoder().decode(Location.self, from: response.data!)
                        print(self.location!)
                        completion()
                    }
                    catch {
                        print("couldn't decode location")
                    }
                }else {
                    self.requestFailed()
                }
        }
    }
    //MARK:- Register chef
    func registerChef(completion: @escaping (_ passed:Bool) -> ()){
        passed = true
        SVProgressHUD.show()
        print(params)
        Alamofire.request(registerChefURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            
            if response.result.isSuccess{
                print(response.result.value!)
                
                let json = JSON(response.result.value!)
                if  json["ResultResponse"].stringValue == "0"	{
                    defaults.set(json["ID"].stringValue, forKey: "_id")
                    defaults.set("signed", forKey: "signed")
                    completion(true)
                    
                }
                else{
                    SVProgressHUD.showError(withStatus: json["Description"].stringValue)
                    SVProgressHUD.dismiss(withDelay: 1.5)
                    
                    completion(false)
                }
                
                            
            }else
            {
                self.requestFailed()
            }
        }
    }
      //MARK:- Login chef
    func loginChef(completion: @escaping () -> ()){
         SVProgressHUD.show()
        Alamofire.request(loginChefURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                if response.result.isSuccess{
                    let json = JSON(response.result.value!)
                    if json["ResultResponse"].stringValue == "0"{
                        defaults.set(json["ID"].stringValue, forKey: "_id")
                        defaults.set(json["ChefPicPath"].stringValue,forKey: "image")
                        defaults.set("signed" , forKey: "signed")
                        completion()

                        
                    }else{
                        SVProgressHUD.showError(withStatus: json["Description"].stringValue)
                    }
                }
                else {
                   self.requestFailed()
                }
        }
        
    }
    //MARK:- send pin code
    func sendPinCode(completion: @escaping ()->()){
        Alamofire.request(sendPinCodeURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                if response.result.isSuccess{
                    let json = JSON(response.result.value!)
                    if json["ResultResponse"].stringValue == "0"{
                        completion()
                    }else {
                        SVProgressHUD.showError(withStatus: json["Description"].stringValue)
                          SVProgressHUD.dismiss(withDelay: 1.5)
                    }
                }else {
                    self.requestFailed()
                }
                
        }
    }
    
    func forgotPassword(completion : @escaping (Bool) -> ()){
        Alamofire.request(forgotPasswordURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON {
                response in
                if response.result.isSuccess{
                    let json = JSON(response.result.value!)
                    if json["ResultResponse"].stringValue == "0"{
                        completion(true)
                    }else {
                        SVProgressHUD.showError(withStatus: json["Description"].stringValue)
                        SVProgressHUD.dismiss(withDelay: 1.5)
                        completion(false)
                    }
                }else {
                    self.requestFailed()
                }
                
                
        }
    }
    func requestFailed(){
        SVProgressHUD.showError(withStatus: "NO Connection!".localized())
        SVProgressHUD.dismiss(withDelay: 1.5)
    }
    func getChefInfo<R>(completion: @escaping onResponse<R>) where R : ChefInfo{
        Alamofire.request(getChefInfoURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response:DataResponse<R>) in
            self.handleCallBack(success: completion , response: response)
        }
    }   
    func handleCallBack<T>(success:@escaping onResponse<T> ,response:DataResponse<T> ){
        
        if let value = response.result.value{
            if JSON(value)["ResultResonse"].stringValue == "0"{
                success(value)
            }else {
                self.requestFailed()
            }
        }
    }
}



// MARK:- Struct Login Chef

struct Login : Codable{
    var ChefFCMID : String
    var ChefPassword : String
    var ChefPhone : String
    var WsPassword : String
    var WsUsername : String
    var device = Device()
}


// MARK:get locations
struct LocationObj : Decodable{
    var LocationID : String
    var LocationName : String
    
}
struct Location : Decodable {
    var Description : String
    var ResultResponse : String
    var Locations : [LocationObj]
}



// MARK:- Device
struct Device : Codable{
    let Platform : String = "iOS"
    let Resolution = "\(screenSize)"
    let Version = systemVersion
    func serializeDevice() -> Dictionary<String , Any>{
        do {
            let jsonData = try JSONEncoder().encode(self)
            
            if let jsonObj = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? Dictionary<String , Any> {
                return jsonObj
            }
            return ["" : ""]
        }
        catch{
            print("Couldn't Encode")
            return ["" : ""]
        }
    }
}


let screenBounds = UIScreen.main.bounds
let screenScale = UIScreen.main.scale
let screenSize = CGSize(width: screenBounds.width * screenScale, height: screenBounds.height * screenScale)
let systemVersion = UIDevice.current.systemVersion

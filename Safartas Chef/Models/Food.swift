//
//  Food.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/20/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import Foundation
import SVProgressHUD
import Alamofire
import SwiftyJSON



class Food : Chef{
    var meals : [Meal]
    var meal : Meal!
    var mealStatus = [String]()
    var switchBool = [Bool]()
    var statusBool = [Bool]()
    override init() {
        meals = []
        super.init()
    }
    //MARK: Get Chef Menu
    func   getChefMenu(completion: @escaping () -> ()) {
        meals = []
        SVProgressHUD.show()
        Alamofire.request(getChefMenuURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (response) in
                if response.result.isSuccess{
                    let json = JSON(response.result.value!)
                    if json["ResultResponse"].stringValue == "0"{
                        for meal in json["Meals"].arrayValue{
                            self.mealStatus.append(meal["MealStatus"].stringValue)
                            if meal["MealStatus"].stringValue == "0"{
                                self.statusBool.append(true)
                            } else {
                                self.statusBool.append( false)
                            }
                           
                            self.meals.append(
                                Meal(
                                    MealActive: meal["MealActive"].stringValue,
                                    MealDesc: meal["MealDesc"].stringValue,
                                    MealEnoughToPeople: meal["MealEnoughToPeople"].stringValue,
                                    MealID: meal["MealID"].stringValue,
                                    MealName: meal["MealName"].stringValue,
                                    MealPicPath: meal["MealPicPath"].stringValue,
                                    MealPreparTime: meal["MealPreparTime"].stringValue,
                                    MealPrice: meal["MealPrice"].stringValue,
                                    Description: "",ResultResponse:""))
                            
                        }
                       
                        self.switchBool = Array(repeating: true, count: self.meals.count)
                        SVProgressHUD.dismiss()
                      
                        completion()
                        
                        // print(self.meals)
                        
                    } else {
                        SVProgressHUD.showError(withStatus: json["Description"].stringValue)
                        SVProgressHUD.dismiss(withDelay: 1.5)
                    }
                }
                else {
                    self.requestFailed()
                }
        }
    }
    //MARK:
    func getMealInfo(completion: @escaping () -> ()){ 
        SVProgressHUD.show()
        Alamofire.request(getMealInfoURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                if response.result.isSuccess{
                    if JSON(response.result.value!)["ResultResponse"].stringValue == "0"{
                        do {
                            self.meal = try JSONDecoder().decode(Meal.self, from: response.data!)
                            SVProgressHUD.dismiss()
                            completion()
                        }
                        catch{
                            print("Couldn't decode Meal")
                        }
                    }
                }else {
                    self.requestFailed()
                }
        }
    }
    //MARK:- AddEditMeal
    func addEditMeal(completion: @escaping() -> ()){
    //    meals = []
        //      params["MealAppOptID"] = params["AppOptID"]
        SVProgressHUD.show()
        print(params)
        Alamofire.request(addEditMealURL, method: .post, parameters: params, encoding: JSONEncoding.default
            , headers: nil )
            .responseJSON{
                response in
                if response.result.isSuccess{
                    let json = JSON(response.result.value!)
                    if json["ResultResponse"].stringValue == "0"{
                        SVProgressHUD.showSuccess(withStatus: json["Description"].stringValue)
                        SVProgressHUD.dismiss(withDelay: 1.5)
                        self.params["MealID"] = json["MealID"].stringValue
                        print(json)
                        completion()
                        //self.meals = []
                    } else {
                        SVProgressHUD.showError(withStatus: json["Description"].stringValue)
                        SVProgressHUD.dismiss(withDelay: 1.5)
                    }
                } else {
                    self.requestFailed()
                }
        }
    }
    //MARK: delete meal
    func deleteMeal(completion:@escaping () ->()) {
        SVProgressHUD.show()
        Alamofire.request(deleteMealURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                if response.result.isSuccess{
                    let json = JSON(response.result.value!)
                    if json["ResultResponse"] == "0"{
                        SVProgressHUD.showSuccess(withStatus: "Deleted Successfully")
                        SVProgressHUD.dismiss(withDelay: 1.5)
                        completion()
                    }
                }
                else {
                    self.requestFailed()
                }
        }
    }
    func uploadMealImage(image:UIImage,completion:@escaping () -> ()){
        let ImgParams : [String:String] = ["WsUsername": "123",
                                           "WsPassword": "123",
                                           "MealID" : (params["MealID"] as? String)!,
                                           "ChefID" : (params["ChefID"] as? String)!]
        print(ImgParams )
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(image.jpegData(compressionQuality: 0)!, withName: "file_name.jpg",mimeType: "image/jpg")
            for (key, value) in ImgParams {
                multipartFormData.append((value).data(using: String.Encoding.utf8)!, withName: key)
            }
            print(image.jpegData(compressionQuality: 0.1)!)
            
        }, to: uploadImgURL) { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    SVProgressHUD.showProgress(Float(progress.fractionCompleted),status:"Uploading...")
                    
                })
                
                upload.responseJSON { response in
                    print(response.result.value!)
                    SVProgressHUD.dismiss()
                    completion()
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
        
        //          let data = image.pngData()!
        //
        //              Alamofire.upload(multipartFormData: { (multipartFormData) in
        //                  multipartFormData.append(data, withName: "file", fileName: "file_name",mimeType: "image/png")
        //                for (key , value) in ImgParams{
        //                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
        //                }
        //              }, usingThreshold: UInt64.init(), to: uploadImgURL, method: .post, headers: nil){
        //          encodingResult in
        //            switch encodingResult {
        //            case .success(let upload, _, _):
        //                upload.responseJSON(completionHandler: { (response) in
        //                    print(response.result.value)
        //                    completion()
        //                })
        //            case .failure(let encodingError):
        //
        //                print(encodingError)
        //                 SVProgressHUD.showError(withStatus: "Check your connection!")
        //            }
        
    }
    
    
    
    
    
    
    
    
}




struct Meal : Decodable{
    var MealActive : String
    var MealDesc: String
    var MealEnoughToPeople : String
    var MealID : String
    var MealName : String
    var MealPicPath : String
    var MealPreparTime : String
    var MealPrice : String
    //  var MealStatus : String
    var Description : String
    var ResultResponse:String
    
}


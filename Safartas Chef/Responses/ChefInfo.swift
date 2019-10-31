//
//  ChefInfo.swift
//  Safartas Chef
//
//  Created by Ammar Al-Helali on 9/29/19.
//  Copyright © 2019 Ammar Al-Helali. All rights reserved.
//

import Foundation
import ObjectMapper

class ChefInfo : Mappable{
    var ChefAddress : String?
    var ChefAreaID : String?
    var ChefBirthdate : String?
    var ChefCloseHour : String?
    var ChefExperienceYears : String?
    var ChefHalal : String?
    var ChefID : String?
    var ChefLang : String?
    var ChefLocation : String?
    var ChefMinimumOrder : String?
    var ChefName : String?
    var ChefNationalityID : String?
    var ChefOpenHour : String?
    var ChefPhone : String?
    var ChefPicPath : String?
    var ChefStatus : String?
    var ChefWorkingDays : String?
    var Description : String?
    var ResultResponse : String?
    
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        ChefAddress         <- map["ChefAddress"]
        ChefID              <- map["ChefID"]
        ChefBirthdate       <- map["ChefBirthdate"]
        ChefCloseHour       <- map["ChefCloseHour"]
        ChefExperienceYears <- map["ChefExperienceYears"]
        ChefHalal           <- map["ChefHalal"]
        ChefID              <- map["ChefID"]
        ChefLang            <- map["ChefLang"]
        ChefLocation        <- map["ChefLocation"]
        ChefMinimumOrder    <- map["ChefMinimumOrder"]
        ChefName            <- map["ChefName"]
        ChefNationalityID   <- map["ChefNationalityID"]
        ChefOpenHour        <- map["ChefOpenHour"]
        ChefPhone           <- map["ChefPhone"]
        ChefPicPath         <- map["ChefPicPath"]
        ChefStatus          <- map["ChefStatus"]
        ChefWorkingDays     <- map["ChefWorkingDays"]
        Description         <- map["Description"]
        ResultResponse      <- map["ResultResponse"]
    }
    
    
}

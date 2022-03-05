//
//  AppConstant.swift
//  Template
//
//  Created by itechnotion on 23/11/21.
//

import Foundation
import UIKit

//var GENERAL_FUNCTION: GeneralFunctions {
//    get {
//        return GeneralFunctions.SharedInstance
//    }
//}


//var FIR_DATA_MANAGER: FIRDataManager {
//    get {
//        return FIRDataManager.sharedInstance()
//    }
//}

var APP_DELEGATE: AppDelegate? {
    get {
        return UIApplication.shared.delegate as? AppDelegate
    }
}


//MARK: - UserDefaults keys
enum UserDefaultKeys: String {
    case isLoggedIn
}

//MARK: - Storyboards
enum StoryBoard {
    static let main : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    static let tabs : UIStoryboard = UIStoryboard(name: "Tabs", bundle: nil)
}

//MARK: - Date Formats
enum DateFormatEnum {
    static let dd_MM_yyyy_HH_mm = "dd-MM-yyyy HH:mm"
    static let bookPurchaseDate = "dd MMM, yyyy"
}

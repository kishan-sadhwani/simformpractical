//
//  ApicallFunc.swift
//  Template
//
//  Created by itechnotion on 23/11/21.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

class ApicallFunc: NSObject {
    
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    //sigletone object to use this file in any screen
    class var sharedInstance: ApicallFunc {
        struct Singleton {
            static let Instance = ApicallFunc()
        }
        return Singleton.Instance
    }
    
    //MARK: - Check Network
    func reachability() -> Bool {
        let reachability = Reachability()
        
        if (reachability?.isReachable)!{
            return true
        }
        else {
            return false
        }
    }
    
    //MARK: API Endpoints
    enum EndPoint: String {
        case LOGIN = "login"
        
        func appending(path: String) -> EndPoint? {
            return EndPoint(rawValue: self.rawValue + path)
        }
    }

//MARK:- when data is in json (when we are getting response in json not in xform)
    func JT_POST(showLoader: Bool = true, endPoint:EndPoint, appending path: String = "", parameter:[String: Any], headers: [String : String], completion: @escaping (_ error: Error?, _ success: Bool, _ result: Any?)->Void){
        
        let url = BASE_URL + endPoint.rawValue + path
        
        var header: HTTPHeaders = [:]
        
        for (k,v) in headers {
            header.add(name: k, value: v)
        }
        print("\n================================\nURL: \(url)\n================================\nParameters:\n\(parameter)\n================================\nHeaders:\n\(header)\n================================")
        if showLoader {
            SVProgressHUD.show()
        }
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            SVProgressHUD.dismiss()
            print("\(response)\n================================")
            switch response.result {
            case .success:

                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
                let DicResponse = response.value as? [String : Any]
                completion(nil, true, DicResponse)
                
            case .failure(let error):
                
                completion(error.underlyingError, false, nil)
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    
    func JT_GET(showLoader: Bool = true, endPoint:EndPoint, appending path: String = "", headers: [String : String], completion: @escaping (_ error: Error?, _ success: Bool, _ result: Any?)->Void){
        
        let url = BASE_URL + endPoint.rawValue + path

        var header: HTTPHeaders = [:]

        for (k,v) in headers {
            header.add(name: k, value: v)
        }
        print("\n================================\nURL: \(url)\n================================\nHeaders:\n\(header)\n================================")
        if showLoader {
            SVProgressHUD.show()
        }
        AF.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            print("\(response)\n================================")
            switch response.result {
            case .success:

                    if showLoader {
                        SVProgressHUD.dismiss()
                    }
                let DicResponse = response.value as? [String : Any]
                completion(nil, true, DicResponse)

            case .failure(let error):

                completion(error.underlyingError, false, nil)
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    
    func JT_DELETE(showLoader: Bool = true, endPoint:EndPoint, appending path: String = "", headers: [String : String], completion: @escaping (_ error: Error?, _ success: Bool, _ result: Any?)->Void){
        
        let url = BASE_URL + endPoint.rawValue + path

        var header: HTTPHeaders = [:]

        for (k,v) in headers {
            header.add(name: k, value: v)
        }
        print("\n================================\nURL: \(url)\n================================\nHeaders:\n\(header)\n================================")
        if showLoader {
            SVProgressHUD.show()
        }
        AF.request(url, method: .delete, parameters: [:], encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            print("\(response)\n================================")
            switch response.result {
            case .success:

                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
                let DicResponse = response.value as? [String : Any]
                completion(nil, true, DicResponse)

            case .failure(let error):

                completion(error.underlyingError, false, nil)
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    
    func JT_PUT(showLoader: Bool = true, endPoint:EndPoint, appending path: String = "", parameter:[String: Any], headers: [String : String], completion: @escaping (_ error: Error?, _ success: Bool, _ result: Any?)->Void){
        
        let url = BASE_URL + endPoint.rawValue + path

        var header: HTTPHeaders = [:]

        for (k,v) in headers {
            header.add(name: k, value: v)
        }
        print("\n================================\nURL: \(url)\n================================\nParameters:\n\(parameter)\n================================\nHeaders:\n\(header)\n================================")
        if showLoader {
            SVProgressHUD.show()
        }
        AF.request(url, method: .put, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print("\(response)\n================================")
            switch response.result {
            case .success:

                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
                let DicResponse = response.value as? [String : Any]
                completion(nil, true, DicResponse)

            case .failure(let error):

                completion(error.underlyingError, false, nil)
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
}

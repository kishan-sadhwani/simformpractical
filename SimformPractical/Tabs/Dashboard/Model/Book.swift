//
//  Book.swift
//  SimformPractical
//
//  Created by Kishan Sadhwani on 05/03/22.
//

import Foundation
import SwiftyJSON

class Book: Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
    
    var author: String?
    var id: String?
    var longDescription: String?
    var name: String?
    var price: String?
    var shortDescription: String?
    var isPurchased: Bool?
    var purchaseDate: String?
    
//    "author"
//    "id"
//    "long_description"
//    "name"
//    "price"
//    "short_description"
//    "is_purchased"
//    "purchase_date"
    
    init(with json: JSON) {
        if json.isEmpty {
            return
        }
        self.author = json["author"].stringValue
        self.id = json["id"].stringValue
        self.longDescription = json["long_description"].stringValue
        self.name = json["name"].stringValue
        self.price = json["price"].stringValue
        self.shortDescription = json["short_description"].stringValue
        self.isPurchased = json["is_purchased"].boolValue
        self.purchaseDate = json["purchase_date"].stringValue
    }
    
    func toDictionary() -> [String:Any] {
        var dictionary = [String:Any]()
        
        if self.author != nil {
            dictionary["author"] = self.author
        }
        if self.id != nil {
            dictionary["id"] = self.id
        }
        if self.longDescription != nil {
            dictionary["long_description"] = self.longDescription
        }
        if self.name != nil {
            dictionary["name"] = self.name
        }
        if self.price != nil {
            dictionary["price"] = self.price
        }
        if self.shortDescription != nil {
            dictionary["short_description"] = self.shortDescription
        }
        if self.isPurchased != nil {
            dictionary["is_purchased"] = self.isPurchased
        }
        if self.purchaseDate != nil {
            dictionary["purchase_date"] = self.purchaseDate
        }
        
        return dictionary
    }
    
}

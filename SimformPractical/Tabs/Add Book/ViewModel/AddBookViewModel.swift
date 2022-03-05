//
//  AddBookViewModel.swift
//  SimformPractical
//
//  Created by Kishan Sadhwani on 05/03/22.
//

import Foundation
import FirebaseDatabase

class AddBookViewModel: NSObject {
    
    var onBookAdd: (()->Void)?
    
    override init() {
        
        super.init()
        
    }
    
    /// Add Book in Database
    func addBook(_ book: Book) {
        let ref = Database.database().reference().child("Books")
            .childByAutoId()
        book.id = ref.key
        ref.setValue(book.toDictionary()) { error, ref in
                //Completion
                self.onBookAdd?()
        }
    }
    
    func validateBookData(_ book: Book) -> Bool {
        var valid = true
        
        if book.name == "" {
            valid = false
            Utility.showSnackbar(message: "Enter valid book name")
        }
        else if book.author == "" {
            valid = false
            Utility.showSnackbar(message: "Enter valid author name")
        }
        else if book.price == "" {
            valid = false
            Utility.showSnackbar(message: "Enter a valid price of the book")
        }
        else if book.shortDescription == "" {
            valid = false
            Utility.showSnackbar(message: "Enter some synopsis for the book")
        }
        else if book.shortDescription?.split(separator: " ").count ?? 0 > 10 {
            valid = false
            Utility.showSnackbar(message: "Enter a shorter synopsis (10 words or less)")
        }
        else if book.longDescription == "" {
            valid = false
            Utility.showSnackbar(message: "Enter a breif description of the book")
        }
        else if book.longDescription?.split(separator: " ").count ?? 0 > 300 {
            valid = false
            Utility.showSnackbar(message: "Enter a shorter descritption (300 words or less)")
        }
        
        return valid
    }
}

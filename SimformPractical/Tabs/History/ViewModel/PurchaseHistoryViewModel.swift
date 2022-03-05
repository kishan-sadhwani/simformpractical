//
//  PurchaseHistoryViewModel.swift
//  SimformPractical
//
//  Created by Kishan Sadhwani on 05/03/22.
//

import Foundation
import FirebaseDatabase
import SwiftyJSON

class PurchaseHistoryViewModel: NSObject {
    
    var books: [Book]
    
    var onBookListUpdate: (()->Void)?
    
    override init() {
        
        books = [Book]()
        
        super.init()
        
        fetchBooks()
    }
    
    /// Fetch purchased books
    func fetchBooks() {
        Database.database().reference().child("Books")
            .queryOrdered(byChild: "is_purchased")
            .queryEqual(toValue: true)
            .observe(.childAdded) { (snapshot) in
            if let bookDict = snapshot.value {
                let bookJson = JSON(bookDict)
                let book = Book(with: bookJson)
                if !self.books.replace(book, with: book) {
                    self.books.append(book)
                }
                self.onBookListUpdate?()
            }
        }
        
        Database.database().reference().child("Books")
            .queryOrdered(byChild: "is_purchased")
            .queryEqual(toValue: true)
            .observe(.childChanged) { (snapshot) in
            if let bookDict = snapshot.value {
                let bookJson = JSON(bookDict)
                let book = Book(with: bookJson)
                if !self.books.replace(book, with: book) {
                    self.books.append(book)
                }
                self.onBookListUpdate?()
            }
        }
        
        Database.database().reference().child("Books")
            .queryOrdered(byChild: "is_purchased")
            .queryEqual(toValue: true)
            .observe(.childRemoved) { (snapshot) in
            if let bookDict = snapshot.value {
                let bookJson = JSON(bookDict)
                self.books.removeAll(where: { $0.id == bookJson["id"].stringValue })
                self.onBookListUpdate?()
            }
        }
    }
    
    /// Get books (optionally filtered using name)
    func getBooks(searchString: String = "") -> [Book] {
        if searchString == "" {
            return books
        } else {
            return books.filter({ $0.name?.lowercased().contains(searchString.lowercased()) ?? false })
        }
    }
    
    ///Buy book
    func deleteBook(_ book: Book) {
        book.isPurchased = false
        book.purchaseDate = ""
        
        guard let bookId = book.id else {
            return
        }
        Database.database().reference().child("Books")
            .child(bookId)
            .setValue(book.toDictionary()) { error, ref in
                //Completion
                self.onBookListUpdate?()
        }
    }
}

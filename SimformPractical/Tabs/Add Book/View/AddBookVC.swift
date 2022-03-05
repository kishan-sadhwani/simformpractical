//
//  AddBookVC.swift
//  SimformPractical
//
//  Created by Kishan Sadhwani on 05/03/22.
//

import UIKit
import SwiftyJSON

class AddBookVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var txtBookName: UITextField!
    @IBOutlet weak var txtBookAuthor: UITextField!
    @IBOutlet weak var txtBookPrice: UITextField!
    @IBOutlet weak var txtBookSynopsis: UITextField!
    @IBOutlet weak var txtBookQuantity: UITextField!
    @IBOutlet weak var tvBookDescription: UITextView!
    @IBOutlet weak var btnSave: PrimaryButton!
    
    //MARK: Data
    var addBookViewModel = AddBookViewModel()

    //MARK: - VC Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.addBookViewModel.onBookAdd = { [weak self] in
            self?.moveToDashboard()
        }
    }
    
    func moveToDashboard() {
        self.tabBarController?.selectedIndex = 0
    }
    
    func clearData() {
        txtBookName.text = ""
        txtBookAuthor.text = ""
        txtBookPrice.text = ""
        txtBookSynopsis.text = ""
        txtBookQuantity.text = ""
        tvBookDescription.text = ""
    }

    //MARK: - Actions
    @IBAction func actionSave(_ sender: Any) {
        let bookJson = JSON([:])
        let book = Book(with: bookJson)
        book.name = txtBookName.text
        book.author = txtBookAuthor.text
        book.price = txtBookPrice.text
        book.shortDescription = txtBookSynopsis.text
        book.longDescription = tvBookDescription.text
        book.isPurchased = false
        book.purchaseDate = ""
        
        if self.addBookViewModel.validateBookData(book) {
            self.addBookViewModel.addBook(book)
        }
    }
}

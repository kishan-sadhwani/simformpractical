//
//  PurchaseHistoryVC.swift
//  SimformPractical
//
//  Created by Kishan Sadhwani on 05/03/22.
//

import UIKit

class PurchaseHistoryVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!

    //MARK: Data
    let purchaseHistoryViewModel = PurchaseHistoryViewModel()
    var books = [Book]()
    
    //MARK: - VC Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTableView()
        
        setupSearchView()
        
        purchaseHistoryViewModel.onBookListUpdate = { [weak self] in
            self?.fetchBooks()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchBooks()
    }
    
    func fetchBooks() {
        self.books = self.purchaseHistoryViewModel.getBooks(searchString: self.searchBar.text ?? "")
        self.tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: CellPurchaseInfo.identifier, bundle: nil), forCellReuseIdentifier: CellPurchaseInfo.identifier)
    }
    
    func setupSearchView() {
        searchBar.delegate = self
    }

    //MARK: - Actions
    @IBAction func actionSearch(_ sender: Any) {
        self.navView.isHidden = true
        self.searchView.isHidden = false
        self.searchBar.becomeFirstResponder()
    }
    
    @objc
    func actionDeleteBook(_ sender: UIButton) {
        let book = self.books[sender.tag]
        self.purchaseHistoryViewModel.deleteBook(book)
    }
    
}
//MARK: - Extension TableView methods
extension PurchaseHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellPurchaseInfo.identifier, for: indexPath) as! CellPurchaseInfo
        
        let book = self.books[indexPath.row]
        cell.lblBookName.text = book.name?.capitalized
        cell.lblAuthorName.text = book.author?.capitalized
        cell.lblPrice.text = book.price
        cell.lblShortDescription.text = book.shortDescription
        cell.lblPurchaseDate.text = Utility.convertDateStringFormat(ofDate: book.purchaseDate ?? "", from: DateFormatEnum.dd_MM_yyyy_HH_mm_ss, to: DateFormatEnum.bookPurchaseDate)
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(actionDeleteBook(_:)), for: .touchUpInside)
        
        return cell
    }
}
//MARK: - Extension Searchbar methods
extension PurchaseHistoryVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.text = ""
        self.navView.isHidden = false
        self.searchView.isHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.fetchBooks()
    }
}

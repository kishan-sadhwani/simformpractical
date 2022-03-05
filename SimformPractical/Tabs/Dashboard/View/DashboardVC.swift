//
//  DashboardVC.swift
//  SimformPractical
//
//  Created by Kishan Sadhwani on 05/03/22.
//

import UIKit

class DashboardVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Data
    let dashboardViewModel = DashboardViewModel()
    var books = [Book]()
    var expandedBook: Book?
    
    //MARK: - VC Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTableView()
        
        setupSearchView()
        
        dashboardViewModel.onBookListUpdate = { [weak self] in
            self?.fetchBooks()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchBooks()
    }
    
    func fetchBooks() {
        self.books = self.dashboardViewModel.getBooks(searchString: self.searchBar.text ?? "")
        self.tableView.reloadData()
    }
     
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: CellBookInfo.identifier, bundle: nil), forCellReuseIdentifier: CellBookInfo.identifier)
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
    func actionBuyBook(_ sender: UIButton) {
        let book = self.books[sender.tag]
        self.dashboardViewModel.buyBook(book)
    }
}

//MARK: - Extension TableView methods
extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellBookInfo.identifier, for: indexPath) as! CellBookInfo
        
        let book = self.books[indexPath.row]
        cell.lblBookName.text = book.name?.capitalized
        cell.lblAuthorName.text = book.author?.capitalized
        cell.lblPrice.text = book.price
        cell.lblShortDescription.text = book.shortDescription
        cell.lblLongDescription.text = book.longDescription
        cell.setPurchased(book.isPurchased ?? false)
        cell.setExpanded(book.id ?? "" == self.expandedBook?.id)
        
        cell.btnPurchaseNow.tag = indexPath.row
        cell.btnPurchaseNow.addTarget(self, action: #selector(actionBuyBook(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.expandedBook == self.books[indexPath.row] {
            self.expandedBook = nil
        } else {
            self.expandedBook = self.books[indexPath.row]
        }
        self.tableView.reloadData()
    }
    
}

//MARK: - Extension Searchbar methods
extension DashboardVC: UISearchBarDelegate {
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

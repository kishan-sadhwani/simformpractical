//
//  CellPurchaseInfo.swift
//  SimformPractical
//
//  Created by Kishan Sadhwani on 05/03/22.
//

import UIKit

class CellPurchaseInfo: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblShortDescription: UILabel!
    @IBOutlet weak var lblPurchaseDate: UILabel!
    
    @IBOutlet weak var btnDelete: PrimaryButton!

    //MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.btnDelete.backgroundColor = .systemRed.withAlphaComponent(0.8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    static var identifier: String {
        get {
            return String(describing: CellPurchaseInfo.self)
        }
    }
}

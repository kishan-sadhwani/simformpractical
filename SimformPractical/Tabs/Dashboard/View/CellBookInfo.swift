//
//  CellBookInfo.swift
//  SimformPractical
//
//  Created by Kishan Sadhwani on 05/03/22.
//

import UIKit

class CellBookInfo: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblShortDescription: UILabel!
    @IBOutlet weak var lblLongDescription: UILabel!
    
    @IBOutlet weak var btnPurchaseNow: PrimaryButton!
    @IBOutlet weak var btnPurchased: PrimaryButton!
    @IBOutlet weak var btnExpandedState: UIButton!
    
    //MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lblLongDescription.isHidden = true
        btnExpandedState.tintColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    static var identifier: String {
        get {
            return String(describing: CellBookInfo.self)
        }
    }
    
    func setExpanded(_ isExpanded: Bool) {
        if isExpanded {
            self.btnExpandedState.isSelected = false
            self.lblLongDescription.isHidden = false
        } else {
            self.btnExpandedState.isSelected = true
            self.lblLongDescription.isHidden = true
        }
    }
    
    func setPurchased(_ isPurchased: Bool) {
        if isPurchased {
            // Purchased book
            self.btnPurchased.isHidden = false
            self.btnPurchaseNow.isHidden = true
            
        } else {
            // Not Purchased yet
            self.btnPurchased.isHidden = true
            self.btnPurchaseNow.isHidden = false
        }
    }
}

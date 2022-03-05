//
//  PrimaryButton.swift
//  Template
//
//  Created by iTechNotion Mac Mini on 01/03/22.
//

import UIKit

@IBDesignable
class PrimaryButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.8)
        self.cornerRadius = 5
        self.borderColor = UIColor.clear
        self.borderWidth = 0
        self.shadowColor = UIColor.black
        self.shadowOpacity = 0
        self.shadowOffset = CGSize(width: 0, height: 0)
        self.setTitleColor(UIColor.white, for: .normal)
        self.tintColor = UIColor.white
    }

    // button corner radius
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
           self.layer.cornerRadius = cornerRadius
        }
    }
    
    // button border colors
    @IBInspectable var borderColor: UIColor? = UIColor.clear {
        didSet {
           self.layer.borderColor = borderColor?.cgColor
        }
    }
    // button border width
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
           self.layer.borderWidth = borderWidth
        }
    }
    
    // button shadow color
    @IBInspectable var shadowColor: UIColor = UIColor.black {
       didSet{
          self.layer.shadowColor = shadowColor.cgColor
          self.layer.masksToBounds = false
       }
    }
    // button shadow opacity
    @IBInspectable var shadowOpacity: Float = 0.3 {
       didSet {
          self.layer.masksToBounds = false
          self.layer.shadowOpacity = shadowOpacity
       }
    }
        
    // button shadow offset
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
           self.layer.masksToBounds = false
           self.layer.shadowOffset = shadowOffset
        }
    }
    
}

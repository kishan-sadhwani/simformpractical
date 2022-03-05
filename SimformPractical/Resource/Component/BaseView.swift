//
//  BaseView.swift
//  Template
//
//  Created by iTechNotion Mac Mini on 01/03/22.
//

import UIKit

class BaseView: UIView {

    

    // corner radius
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
           self.layer.cornerRadius = cornerRadius
        }
    }
    
    // border colors
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
           self.layer.borderColor = borderColor.cgColor
        }
    }
    // border width
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
           self.layer.borderWidth = borderWidth
        }
    }
    
    // shadow radius
    @IBInspectable var shadowRadius: CGFloat = CGFloat(0.5) {
       didSet {
          self.layer.masksToBounds = false
          self.layer.shadowRadius = shadowRadius
       }
    }
    
    // shadow color
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
       didSet{
          self.layer.shadowColor = shadowColor.cgColor
          self.layer.masksToBounds = false
       }
    }
    // shadow opacity
    @IBInspectable var shadowOpacity: Float = 0.4 {
       didSet {
          self.layer.masksToBounds = false
          self.layer.shadowOpacity = shadowOpacity
       }
    }
        
    // shadow offset
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 1, height: 4) {
        didSet {
           self.layer.masksToBounds = false
           self.layer.shadowOffset = shadowOffset
        }
    }
}

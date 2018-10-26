//
//  UITextField + Style.swift
//  Maeen
//
//  Created by yahya alshaar on 10/5/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

extension UITextField {
    func style(withImage image: UIImage? = nil) {
        
        let primaryColor = UIColor.white
        
        // border
        borderStyle = .none
        layer.borderColor = primaryColor.cgColor
        layer.borderWidth = 1
        
        // background
        layer.backgroundColor = primaryColor.withAlphaComponent(0.2).cgColor
        
        
        // left view
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        leftView = imageView
        leftViewMode = .always
        
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 44))
        
        // style
        tintColor = primaryColor
        textColor = primaryColor
        
        if UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft {
            textAlignment = .right
        }else {
            textAlignment = .left
        }
        
        font = UIFont.font(from: .text)
        
    }
}

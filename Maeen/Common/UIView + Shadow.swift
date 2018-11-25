//
//  UIView + Shadow.swift
//  Maeen
//
//  Created by yahya alshaar on 9/1/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.8).cgColor //UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

//
//  UITableViewController + Welcoming.swift
//  Maeen
//
//  Created by yahya alshaar on 6/5/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

extension UITableView {
    /**
     prepare on-boarding style
     */
    func prepareStyleOnBoarding() {
        let imageView = UIImageView(image: UIImage(named: "OnBoardingBG"))
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        separatorStyle = .none
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(blurView)
        imageView.addConstraints([
            NSLayoutConstraint(item: blurView, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: blurView, attribute: .bottom, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: blurView, attribute: .leading, relatedBy: .equal, toItem: imageView, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: blurView, attribute: .trailing, relatedBy: .equal, toItem: imageView, attribute: .trailing, multiplier: 1.0, constant: 0)
            ])
        backgroundView = imageView
    }
}

//
//  PackageTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 8/23/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class PackageTableViewCell: UITableViewCell {

    @IBOutlet weak var lblOldPrice: UILabel!
    @IBOutlet weak var lblNewPrice: UILabel!
    @IBOutlet weak var lblSubscriptionPeriod: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var btnPositive: UIButton!
    @IBOutlet weak var priceView: UIView!
    
    var package: Package! {
        didSet {
            lblTitle.text = package.title
            lblSubtitle.text = package.details
            
            componentTintColor = package.color
            
            lblOldPrice.text = package.priceComponent.old.displayed
            lblNewPrice.text = package.priceComponent.new.displayed
            lblSubscriptionPeriod.text = package.subscriptionPeriod
            
            
        }
    }
    private var componentTintColor: UIColor! {
        didSet {
            lblTitle.textColor = componentTintColor
            btnPositive.layer.backgroundColor = componentTintColor.cgColor
            priceView.backgroundColor = componentTintColor
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblSubtitle.textColor = UIColor.secondary
        lblNewPrice.textColor = UIColor.white
        lblOldPrice.textColor = UIColor.white
        lblSubscriptionPeriod.textColor = UIColor.white
        
        btnPositive.tintColor = UIColor.white
        btnPositive.setTitle("subscribeNow".localized(), for: .normal)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        priceView.layer.cornerRadius = priceView.frame.height / 2
        btnPositive.layer.cornerRadius = btnPositive.frame.height / 2
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  PaymentItemTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 9/23/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class PaymentItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override var isSelected: Bool {
        didSet {
            
            let selectedView = UIView()
            
            if isSelected {
                accessoryType = .checkmark
                selectedView.backgroundColor = UIColor.tint.withAlphaComponent(0.2)
                
            }else {
                accessoryType = .none
                selectedView.backgroundColor = UIColor.white
            }
            
            selectedBackgroundView = selectedView
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

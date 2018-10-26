//
//  ProfileTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 9/4/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var roundedView: ShadowView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.textColor = UIColor.tint
        lblValue.textColor = UIColor.secondary
        roundedView.layer.cornerRadius = 8
        
    }
    var title: String? {
        didSet {
            lblTitle.text = title
        }
    }
    var value: String? {
        didSet {
            lblValue.text = value
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  ProfileComponentTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 9/24/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class ProfileComponentTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var component: ProfileComponent! {
        didSet {
            iconImageView.image = component.icon
            titleLabel.text = component.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.tintColor = UIColor.primary
        titleLabel.textColor = UIColor.primary
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

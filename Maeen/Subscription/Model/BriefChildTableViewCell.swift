//
//  BriefChildTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 9/10/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class BriefChildTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    
    var child: Child! {
        didSet {
            lblTitle.text = child.name
            lblSubtitle.text = child.displayedAge
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override var isSelected: Bool {
        didSet {
            let selectedView = UIView()
            
            if isSelected {
                selectedView.backgroundColor = UIColor.tint.withAlphaComponent(0.2)
                accessoryType = .checkmark
            }else {
                selectedView.backgroundColor = UIColor.white
                accessoryType = .none
            }
            
            selectedBackgroundView = selectedView
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class var identifier: String {
        return "BriefChildCell"
    }
}

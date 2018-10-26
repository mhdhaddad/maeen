//
//  TotalTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 9/14/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class TotalTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    
    var total: Total! {
        didSet {
            lblTitle.text = total.title
            lblSubtitle.text = total.price.displayed
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.textColor = UIColor.primary
        lblSubtitle.textColor = UIColor.secondary
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

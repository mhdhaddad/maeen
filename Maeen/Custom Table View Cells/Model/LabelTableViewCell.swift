//
//  LabelTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 6/9/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.font = UIFont.font(from: .body)
        lblTitle.textColor = UIColor.secondary
    }
    
    static var nib: UINib = { UINib(nibName: "LabelTableViewCell", bundle: nil) }()
    
    class var identifer: String {
        return "LabelTableViewCell"
    }
}

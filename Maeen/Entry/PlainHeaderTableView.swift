//
//  PlainHeaderTableView.swift
//  Maeen
//
//  Created by yahya alshaar on 10/6/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class PlainHeaderTableView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = UIColor.primary
        titleLabel.font = UIFont.font(from: .title2)
    }
    
    class var identifier: String {
        return "PlainHeaderTableView"
    }
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

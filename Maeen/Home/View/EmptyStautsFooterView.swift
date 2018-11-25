//
//  EmptyStautsFooterView.swift
//  Maeen
//
//  Created by yahya alshaar on 11/11/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class EmptyStautsFooterView: UITableViewHeaderFooterView {

    @IBOutlet weak var messageLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    class var identifier: String {
        return "EmptyStautsFooterView"
    }
    
    static var nib: UINib = {
        return UINib(nibName: identifier, bundle: nil)
    }()
    
    var message: String? {
        didSet {
            messageLabel.text = message
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageLabel.font = UIFont.font(from: .subTitle1)
        messageLabel.textColor = UIColor.secondary
    }
}

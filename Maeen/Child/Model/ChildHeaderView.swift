//
//  ChildHeaderView.swift
//  Maeen
//
//  Created by yahya alshaar on 6/9/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class ChildHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func btnAction_TouchUpInside(sender: Any) {
        
    }
    
    class var identifier: String {
        return "ChildHeaderView"
    }
    static var nib: UINib = {  UINib(nibName: identifier, bundle: nil) }()
}

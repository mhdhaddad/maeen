//
//  OBTextField.swift
//  Maeen
//
//  Created by yahya alshaar on 7/8/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class OBTextField: UIView {
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var view: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "OBTextField", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
    }
}

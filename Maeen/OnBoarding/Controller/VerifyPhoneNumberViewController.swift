//
//  VerifyPhoneNumberViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 6/9/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class VerifyPhoneNumberViewController: UIViewController {
    @IBOutlet weak var txtValidationCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Verify your number".localized()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txtValidationCode.becomeFirstResponder()
    }
}

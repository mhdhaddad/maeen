//
//  SignUpViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 7/8/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import PopupDialog

class SignUpViewController: UIViewController {
    @IBOutlet weak var btnPositive: UIButton!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFirstName.style(withImage: #imageLiteral(resourceName: "nameIcon"))
        txtLastName.style(withImage: #imageLiteral(resourceName: "nameIcon"))
        txtEmail.style(withImage: #imageLiteral(resourceName: "emailIcon"))
        txtPassword.style(withImage: #imageLiteral(resourceName: "passwordIcon"))
        
        txtLastName.placeholder = "lastName".localized()
        txtFirstName.placeholder = "firstName".localized()
        txtEmail.placeholder = "email".localized()
        txtPassword.placeholder = "password".localized()
        
        btnPositive.titleLabel?.font = UIFont.font(from: .action)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        txtFirstName.layer.cornerRadius = txtFirstName.frame.height / 2
        txtLastName.layer.cornerRadius = txtLastName.frame.height / 2
        txtEmail.layer.cornerRadius = txtEmail.frame.height / 2
       
        txtPassword.layer.cornerRadius = txtPassword.frame.height / 2
        
        btnPositive.layer.cornerRadius = btnPositive.frame.height / 2
    }
    @IBAction func btnPositive_TouchUpInside(_ sender: Any) {
        guard let firstName = txtFirstName.text, let lastName = txtLastName.text, let email = txtEmail.text, let password = txtPassword.text else {
            return
        }
        
        let waitingPopup = PopupDialog.waitingPopup()
        present(waitingPopup, animated: true, completion: nil)
        
        Lookup.shared.register(email: email, password: password, firstName: firstName, lastName: lastName, success: { (attributes) in
            waitingPopup.dismiss(animated: true, completion: {
                app.account.authentication(attributes: attributes)
                
                let title = "registrationSuccessful".localized()
                let message = "registrationSuccessfulMessage".localized()
                
                let popup = PopupDialog(title: title, message: message)
                UIApplication.shared.keyWindow?.rootViewController?.present(popup, animated: true, completion: {
                    (UIApplication.shared.delegate as? AppDelegate)?.makeRoot(viewController: Navigation.home())
                })
            })
        }) { (error) in
            waitingPopup.dismiss(animated: true, completion: {
                let title = "error".localized()
                let message = error.localizedDescription
                
                let popup = PopupDialog(title: title, message: message)
                UIApplication.shared.keyWindow?.rootViewController?.present(popup, animated: true, completion: nil)
                
            })
        }
        
    }
}

//
//  SignInViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 7/7/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import PopupDialog

class SignInViewController: UIViewController {
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnPositive: UIButton!
    @IBOutlet weak var idSegmentControl: UISegmentedControl!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor.tint
        
        let font = UIFont.font(from: .action)
        idSegmentControl.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
        
        btnPositive.layer.backgroundColor = UIColor.white.cgColor
        btnPositive.titleLabel?.font = UIFont.font(from: .action)
        btnForgotPassword.titleLabel?.font = UIFont.font(from: .secondryAction)
        
        prepareIdTextField(isEmail: true)
        
        txtPassword.style(withImage: #imageLiteral(resourceName: "passwordIcon"))
        txtPassword.placeholder = "password".localized()
        
        lblSubtitle.font = UIFont.font(from: .title1)
    }
    private func prepareIdTextField(isEmail: Bool) {
        if isEmail {
            txtId.style(withImage: #imageLiteral(resourceName: "emailIcon"))
            txtId.placeholder = "email".localized()
        }else {
            txtId.style(withImage: #imageLiteral(resourceName: "phoneIcon"))
            txtId.placeholder = "phoneNumber".localized()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnPositive.layer.cornerRadius = btnPositive.frame.height / 2
        
        txtId.layer.cornerRadius = txtId.bounds.height / 2
        txtPassword.layer.cornerRadius = txtId.bounds.height / 2
    }
    @IBAction func btnPositive_TouchUpInside(_ sender: Any) {
        guard let username = txtId.text, let password = txtPassword.text else {
            return
        }
        let waitingPopup = PopupDialog.waitingPopup()
        present(waitingPopup, animated: true, completion: nil)
        
        Lookup.shared.auth(username: username, password: password, success: { (attributes) in
            app.account.authentication(attributes: attributes)
            
            waitingPopup.dismiss(animated: true, completion: {
                (UIApplication.shared.delegate as? AppDelegate)?.makeRoot(viewController: Navigation.home())
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
    @IBAction func idSegmentControl_ValueChanged(_ sender: UISegmentedControl) {
        prepareIdTextField(isEmail: sender.selectedSegmentIndex == 0)
    }
}

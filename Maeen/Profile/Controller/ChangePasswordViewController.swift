//
//  ChangePasswordViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 9/24/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import JGProgressHUD

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var oldPasswordTitleLabel: UILabel!
    @IBOutlet weak var newPasswordTitleLabel: UILabel!
    @IBOutlet weak var confirmationPasswordTitleLabel: UILabel!
    
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmationPasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var btnPositive: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "changePassword".localized()
        
        oldPasswordTitleLabel.text = "oldPassword".localized()
        newPasswordTitleLabel.text = "newPassword".localized()
        confirmationPasswordTitleLabel.text = "confirmPassword".localized()
        
        btnPositive.backgroundColor = UIColor.tint
        btnPositive.setTitle("saveChanges".localized(), for: .normal)
        btnPositive.setImage(#imageLiteral(resourceName: "saveIcon"), for: .normal)
        btnPositive.tintColor = UIColor.white
        
        if UIView.userInterfaceLayoutDirection(for: btnPositive.semanticContentAttribute) == .rightToLeft {
            btnPositive.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -16)
        }else {
            btnPositive.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        }
        
        errorLabel.textColor = UIColor.tintRed
        
        togglePositiveAction(enabled: false)
        toggleErrorMessage(enabled: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnPositive_TouchUpInside(_ sender: Any) {
        let indicator = JGProgressHUD(style: .dark)
        indicator.textLabel.text = "loading".localized()
        indicator.show(in: self.view)
        
        Lookup.shared.resetPassword(current: oldPasswordTitleLabel.text!, new: newPasswordTextField.text!, confirmed: confirmationPasswordTextField.text!, success: { [weak self] in
            
            UIView.animate(withDuration: 0.1, animations: {
                indicator.textLabel.text = "successfullySent".localized()
                indicator.indicatorView = JGProgressHUDSuccessIndicatorView()
            })
            
            indicator.dismiss(afterDelay: 1.0)
            
            self?.oldPasswordTextField.text = nil
            self?.newPasswordTextField.text = nil
            self?.confirmationPasswordTextField = nil
            
        }) { (error) in
            UIView.animate(withDuration: 0.1, animations: {
                indicator.textLabel.text = "failedToSend".localized()
                indicator.indicatorView = JGProgressHUDErrorIndicatorView()
            })
            
            indicator.dismiss(afterDelay: 2.0)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnPositive.layer.cornerRadius = btnPositive.bounds.height / 2
    }
    @IBAction func oldPasswordTextField_EditingChanged(_ sender: UITextField) {
        checkPositiveActionAbility()
    }
    @IBAction func newPasswordTextField_EditingChanged(_ sender: UITextField) {
        checkPositiveActionAbility()
    }
    @IBAction func confirmedPasswordTextField_EditingChanged(_ sender: UITextField) {
        checkPositiveActionAbility()
    }
    
    func checkPositiveActionAbility() {
        let shouldBeEnabled = oldPasswordTextField.text?.isEmpty ?? true == false && newPasswordTextField.text?.isEmpty ?? true == false && confirmationPasswordTextField.text?.isEmpty ?? true == false
        
        let isPasswordIdentical = newPasswordTextField.text == confirmationPasswordTextField.text
        
        togglePositiveAction(enabled: shouldBeEnabled && isPasswordIdentical)
        
        if shouldBeEnabled  {
            toggleErrorMessage(enabled: !isPasswordIdentical, message: "passwordNotMatch".localized())
        }
        
    }
    func toggleErrorMessage(enabled: Bool, message: String? = nil) {
        errorLabel.isHidden = !enabled
        errorLabel.text = message
    }
    func togglePositiveAction(enabled: Bool) {
        if enabled {
            btnPositive.alpha = 1
        }else {
            btnPositive.alpha = 0.6
        }
        btnPositive.isUserInteractionEnabled = enabled
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

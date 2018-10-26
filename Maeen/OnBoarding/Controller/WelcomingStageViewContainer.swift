//
//  WelcomingStageViewContainer.swift
//  Maeen
//
//  Created by yahya alshaar on 5/23/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class WelcomingStageViewContainer: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnPositive: UIButton!
    
    var destination: UIViewController! {
        didSet {

        }
    }
    var delegate: WelcomingStageViewContainerDelegate?
    @IBOutlet weak var constraintBottomPositiveAction: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        destination.view.frame = containerView.frame
        containerView.addSubview(destination.view)
        
        addChildViewController(destination)
        
        if destination.isKind(of: EmailViewController.self), let vc = destination as? EmailViewController {
            vc.delegate = self
        }
        
        destination.didMove(toParentViewController: self)
        title = destination.title
        setupButtons()
        
//        btnPositive.isEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
    }
    private func setupButtons() {
        btnPositive.backgroundColor = UIColor.tint
        btnPositive.tintColor = UIColor.white
        btnPositive.layer.borderColor = UIColor.white.cgColor
        btnPositive.layer.borderWidth = 0.6
        
        if destination.isKind(of: VerifyPhoneNumberViewController.self) {
            btnPositive.setTitle("verify".localized().uppercased(), for: .normal)
        }else {
            btnPositive.setTitle("next".localized().uppercased(), for: .normal)
        }

    }
    @IBAction func btnPositive_TouchUpInside(_ sender: Any) {
        if destination.isKind(of: EmailViewController.self) {
            navigationController?.pushViewController(Navigation.stage(destination: Navigation.password()), animated: true)
        }else if destination.isKind(of: PasswordViewController.self) {
            
            navigationController?.pushViewController(Navigation.stage(destination: Navigation.phoneNumber()), animated: true)
        }else if destination.isKind(of: PhoneNumberViewController.self) {
            navigationController?.pushViewController(Navigation.stage(destination: Navigation.verifyPhoneNumber()), animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnPositive.layer.cornerRadius = btnPositive.frame.height / 2
    }
    
    @objc func handleKeyboardNotification(notification: Notification) {
        
        if let userInfo = notification.userInfo {
            
            if let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect {
                print(keyboardFrame)
                
                let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
                constraintBottomPositiveAction?.constant = isKeyboardShowing ? keyboardFrame.height : 20
                
                UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                }) { (completed) in
                }
            }
        }
    }
}

protocol WelcomingStageViewContainerDelegate {
    func didTriggerPositiveAction()
    func enablePositiveAction()
    func disablePositiveAction()
}

extension WelcomingStageViewContainer: WelcomingStageViewContainerDelegate {
    func didTriggerPositiveAction() {
        
    }
    
    func enablePositiveAction() {
        btnPositive.isEnabled = true
    }
    
    func disablePositiveAction() {
        btnPositive.isEnabled = false
    }
    
    
}

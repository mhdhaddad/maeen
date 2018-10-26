//
//  WelcomingViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 5/23/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class WelcomingViewController: UIViewController {
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnNegative: UIButton!
    
    var context: ContextKind = .normal

    enum ContextKind {
        case root
        case normal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        lblMessage.font = UIFont(name: AdirBold, size: 20)
        
        btnSignIn.titleLabel?.font = UIFont.font(from: .action)
        btnSignUp.titleLabel?.font = UIFont.font(from: .action)
        
        btnSignUp.setTitle("signUp".localized(), for: .normal)
        btnSignIn.setTitle("signIn".localized(), for: .normal)
        
        
        btnSignIn.tintColor = UIColor.tint
        btnSignIn.layer.backgroundColor = UIColor.white.cgColor
        
        btnSignUp.layer.borderWidth = 1
        btnSignUp.layer.borderColor = UIColor.white.cgColor
        btnSignUp.tintColor = UIColor.white
        
        
        btnNegative.tintColor = UIColor.white
        btnNegative.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
        
        switch context {
        case .root:
            btnNegative.isHidden = true
        default:
            btnNegative.isHidden = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnSignIn.layer.cornerRadius = btnSignIn.frame.height / 2
        btnSignUp.layer.cornerRadius = btnSignUp.frame.height / 2
        btnNegative.layer.cornerRadius = btnNegative.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignInSegue" {
            let destination = segue.destination as! WelcomingStageViewContainer
            destination.destination = Navigation.signIn()
            
        }else if segue.identifier == "SignUpSegue" {
            let stage = segue.destination as! WelcomingStageViewContainer
            stage.destination = Navigation.email()
        }
    }
    @IBAction func btnNegative_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

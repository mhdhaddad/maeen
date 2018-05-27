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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        btnSignUp.setTitle("signUp".localized(), for: .normal)
        btnSignIn.setTitle("signIn".localized(), for: .normal)
        
        
        btnSignIn.tintColor = UIColor.white
        btnSignIn.layer.backgroundColor = UIColor.tint.cgColor
        
        btnSignUp.layer.borderWidth = 1
        btnSignUp.layer.borderColor = UIColor.tint.cgColor
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnSignIn.layer.cornerRadius = btnSignIn.frame.height / 2
        btnSignUp.layer.cornerRadius = btnSignUp.frame.height / 2
        
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
            destination.destination = UIStoryboard.init(name: "Welcoming", bundle: nil).instantiateViewController(withIdentifier: "SignInVC")
            
        }else if segue.identifier == "SignUpSegue" {
            let stage = segue.destination as! WelcomingStageViewContainer
            stage.destination = UIStoryboard.init(name: "Welcoming", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC")
        }
    }
}

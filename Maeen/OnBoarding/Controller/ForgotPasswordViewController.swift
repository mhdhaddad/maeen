//
//  ForgotPasswordViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 7/21/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var usernameSegment: UISegmentedControl!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var btnPositive: UIButton!
    @IBOutlet weak var btnPhoneNumber: UIButton!
    
    lazy var countries: [String: String] = { Utility.countries() }()
    
    enum UsernameMode: Int {
        case email = 0
        case mobile = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "forgotPasswordTitle".localized()
        lblTitle.text = title
        
        btnPositive.layer.backgroundColor = UIColor.white.cgColor
        btnPositive.setTitle("send".localized(), for: .normal)
        btnPositive.titleLabel?.font = UIFont.font(from: .action)
        
        btnPhoneNumber.titleLabel?.font = UIFont.font(from: .text)
        let font = UIFont.font(from: .action)
        usernameSegment.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
        
        usernameSegment.selectedSegmentIndex = 0
        usernameSegment.sendActions(for: .valueChanged)
        
        lblTitle.font = UIFont.font(from: .title1)
        
        
//        txtUsername.style(withImage: #imageLiteral(resourceName: "emailIcon"))
//        txtUsername.placeholder = "email".localized()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CountryCodeSegue" {
            let vc = segue.destination as! CommonTableViewController
            vc.strings = Array(countries.values)
//            vc.delegate = self
        }
    }
 
    @IBAction func btnPositive_TouchUpInside(_ sender: Any) {
        guard let username = txtUsername.text else {
            return
        }
        
        if usernameSegment.selectedSegmentIndex == UsernameMode.email.rawValue {
            Lookup.shared.resetBy(email: username, success: {
                
            }) { (error) in
                //TODO: error
            }
        }else {
            Lookup.shared.resetBy(mobile: username, success: {
                
            }) { (error) in
                //TODO: error
            }
        }
        
    }
    @IBAction func usernameSegment_ValueChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == UsernameMode.email.rawValue {
            txtUsername.style(withImage: #imageLiteral(resourceName: "emailIcon"))
            txtUsername.placeholder = "email".localized()
            btnPhoneNumber.isHidden = true
        }else {
            txtUsername.style(withImage: #imageLiteral(resourceName: "phoneIcon"))
            txtUsername.placeholder = "phoneNumber".localized()
            btnPhoneNumber.isHidden = false
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnPositive.layer.cornerRadius = btnPositive.layer.frame.height / 2
        txtUsername.layer.cornerRadius = txtUsername.frame.height / 2
    }
}

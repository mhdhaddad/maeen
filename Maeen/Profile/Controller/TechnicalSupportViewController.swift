//
//  TechnicalSupportViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 9/27/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import JGProgressHUD

class TechnicalSupportViewController: UIViewController {
    @IBOutlet weak var communicationLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressValueLabel: UILabel!
    
    @IBOutlet weak var educatorServiceLabel: UILabel!
    @IBOutlet weak var educatorServiceValueLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailValueLabel: UILabel!
    
    @IBOutlet weak var technicalSupportLabel: UILabel!
    @IBOutlet weak var technicalSupportDetailsLabel: UILabel!
    
    @IBOutlet weak var inquiryLabel: UILabel!
    @IBOutlet weak var inquirytextField: UITextField!
    
    @IBOutlet weak var inquiryDetailsLabel: UILabel!
    @IBOutlet weak var inquiryDetailsTextView: UITextView!
    
    @IBOutlet weak var positiveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "technicalSupport".localized()
        
        // Style
        communicationLabel.textColor = UIColor.primary
        communicationLabel.font = UIFont(name: "Adir-Bold", size: 25)
        
        addressLabel.textColor = UIColor.primary
        addressValueLabel.textColor = UIColor.secondary
        
        emailLabel.textColor = UIColor.primary
        emailValueLabel.textColor = UIColor.secondary
        
        educatorServiceLabel.textColor = UIColor.primary
        educatorServiceValueLabel.textColor = UIColor.secondary
        
        technicalSupportLabel.textColor = UIColor.primary
        technicalSupportDetailsLabel.textColor = UIColor.secondary
        
        inquiryLabel.textColor = UIColor.primary
        inquiryDetailsLabel.textColor = UIColor.primary
        
        let borderColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1)
        
        positiveButton.setTitle("send".localized(), for: .normal)
        positiveButton.setImage(#imageLiteral(resourceName: "sendIcon"), for: .normal)
        positiveButton.backgroundColor = UIColor.tint
        positiveButton.tintColor = UIColor.white
        
        if UIView.userInterfaceLayoutDirection(for: positiveButton.semanticContentAttribute) == .rightToLeft {
            positiveButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -16)
        }else {
            positiveButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        }
        
        // Data
        communicationLabel.text = "communicationInformation".localized()
        
        addressLabel.text = "address".localized()
        addressValueLabel.text = "maeenAddress".localized()
        
        educatorServiceLabel.text = "educatorService".localized()
        educatorServiceValueLabel.text = "+965-99967617, +966-500395251"
        
        emailLabel.text = "email".localized()
        emailValueLabel.text = "info@maeen.org"
        
        technicalSupportLabel.text = "technicalSupport".localized()
        technicalSupportDetailsLabel.text = "technicalSupportMessage".localized()
        
        
        inquiryLabel.text = "inquiryTitle".localized()
        inquiryDetailsLabel.text = "inquiryDetails".localized()
        
        inquirytextField.layer.borderWidth = 1
        inquirytextField.layer.borderColor = borderColor.cgColor
        inquirytextField.layer.cornerRadius = 8
        
        inquiryDetailsTextView.layer.borderWidth = 1
        inquiryDetailsTextView.layer.cornerRadius = 8
        inquiryDetailsTextView.layer.borderColor = borderColor.cgColor
        
        
        inquiryDetailsTextView.delegate = self
        togglePositiveAction(enabled: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        positiveButton.layer.cornerRadius = positiveButton.bounds.height / 2
    }
    @IBAction func positiveButton_TouchUpInside(_ sender: Any) {
        guard let subject = inquirytextField.text, let message = inquiryDetailsTextView.text else { return }
        
        let indicator = JGProgressHUD(style: .dark)
        indicator.textLabel.text = "loading".localized()
        indicator.show(in: self.view)
        
        Lookup.shared.contact(subject: subject, message: message, success: { [weak self] in
            UIView.animate(withDuration: 0.1, animations: {
                indicator.textLabel.text = "successfullySent".localized()
                indicator.indicatorView = JGProgressHUDSuccessIndicatorView()
            })
            
            indicator.dismiss(afterDelay: 1.0)
            
            self?.inquiryDetailsTextView.text = ""
            self?.inquirytextField.text = nil
        }) { (error) in
            UIView.animate(withDuration: 0.1, animations: {
                indicator.textLabel.text = "failedToSend".localized()
                indicator.indicatorView = JGProgressHUDErrorIndicatorView()
            })
            
            indicator.dismiss(afterDelay: 2.0)
        }
    }
    
    
    @IBAction func inquiryTextField(_ sender: UITextField) {
        checkPositiveActionAbility()
    }
    
    func checkPositiveActionAbility() {
        let shouldBeEnabled = inquiryDetailsTextView.text.isEmpty == false && inquirytextField.text?.isEmpty ?? true == false
        
        togglePositiveAction(enabled: shouldBeEnabled)
    }
    func togglePositiveAction(enabled: Bool) {
        if enabled {
            positiveButton.alpha = 1
        }else {
            positiveButton.alpha = 0.6
        }
        positiveButton.isUserInteractionEnabled = enabled
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
extension TechnicalSupportViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkPositiveActionAbility()
    }
}

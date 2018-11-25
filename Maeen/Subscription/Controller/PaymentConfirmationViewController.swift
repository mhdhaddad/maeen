//
//  PaymentConfirmationViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 9/22/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class PaymentConfirmationViewController: UIViewController {

    @IBOutlet weak var positiveButtonVerticalSpacingPaymentStatusViewConstriant: NSLayoutConstraint!
    @IBOutlet weak var positiveButtonVerticalSpacingPaymentInformationConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var positiveButton: UIButton!
    @IBOutlet weak var paymentStatusImageView: UIImageView!
    @IBOutlet weak var paymentStatusLabel: UILabel!
    
    @IBOutlet weak var paymentNumberLabel: UILabel!
    @IBOutlet weak var paymentNumberTitleLabel: UILabel!
    
    @IBOutlet weak var trackNumberLabel: UILabel!
    @IBOutlet weak var trackNumberTitleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var paymentInformationView: UIView!
    
    var trackId: String!
    enum StatusKind {
        case success
        case failure
    }
    
    var status = StatusKind.failure
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "paymentConfirmation".localized()
        positiveButton.backgroundColor = UIColor.tint
        positiveButton.tintColor = UIColor.white
        positiveButton.imageView?.contentMode = .scaleAspectFit
//        positiveButton.imageView?.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: positiveButton.bounds.height / 2, height: positiveButton.bounds.height))
        
        if UIView.userInterfaceLayoutDirection(for: positiveButton.semanticContentAttribute) == .rightToLeft {
            positiveButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -16)
        }else {
            positiveButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        }
        
        paymentStatusLabel.textColor = UIColor.primary
        
        switch status {
        case .success:
            paymentStatusImageView.image = #imageLiteral(resourceName: "successfulIcon")
            paymentStatusLabel.text = "successfulPayment".localized()
            positiveButton.setTitle("backToSubscription".localized(), for: .normal)
            positiveButton.setImage(#imageLiteral(resourceName: "backIcon"), for: .normal)
            
            fetchPaymentInformation()
            trackNumberTitleLabel.text = "paymentNumber".localized()
            amountTitleLabel.text = "amount".localized()
            dateTitleLabel.text = "date".localized()
        case .failure:
            paymentStatusImageView.image = #imageLiteral(resourceName: "failedIcon")
            paymentStatusLabel.text = "failurePayment".localized()
            positiveButton.setTitle("tryAgain".localized(), for: .normal)
            positiveButton.setImage(#imageLiteral(resourceName: "renewalIcon"), for: .normal)
        }
        
        
        togglePaymentInformation(enabled: status == .success)
        paymentInformationView.isHidden = status == .failure
    }

    func fetchPaymentInformation() {
        Lookup.shared.paymentInformation(trackId: trackId, success: { [weak self] (payment) in
//            guard case self = self else { return }
            guard let `self` = self else {
                return
            }
            self.trackNumberLabel.text = payment.id
            self.amountLabel.text = payment.displayedAmount
            self.dateLabel.text = payment.createdAt?.displayed
            
        }) { (error) in
            //TODO: handle error
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func togglePaymentInformation(enabled: Bool) {
        
        if enabled {
            positiveButtonVerticalSpacingPaymentStatusViewConstriant.priority = .defaultLow
            positiveButtonVerticalSpacingPaymentInformationConstraint.priority = .defaultHigh
        }else {
            positiveButtonVerticalSpacingPaymentStatusViewConstriant.priority = .defaultHigh
            positiveButtonVerticalSpacingPaymentInformationConstraint.priority = .defaultLow
        }
        
        view.layoutIfNeeded()
    }
    @IBAction func positiveButton_TouchUpInside(_ sender: Any) {
        switch status {
        case .success:
            performSegue(withIdentifier: "unwindToSubscriptions", sender: self)
        case .failure:
            performSegue(withIdentifier: "unwindToCheckout", sender: self)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        positiveButton.layer.cornerRadius = positiveButton.bounds.height / 2
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToSubscriptions" {
            let vc = segue.destination as! SubscriptionsViewController
//            vc.didAddSubscripition
        }
    }
    

}

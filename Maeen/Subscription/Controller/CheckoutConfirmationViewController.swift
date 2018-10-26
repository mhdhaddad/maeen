//
//  CheckoutConfirmationViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 9/11/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class CheckoutConfirmationViewController: UIViewController {

    var package: Package!
    var payment: PaymentItem!
    var childIds: [Int32]!
    
    @IBOutlet weak var lblSubscriptionTitle: UILabel!
    @IBOutlet weak var lblSubscriptionSubtitle: UILabel!
    
    @IBOutlet weak var btnPositive: UIButton!
    
    @IBOutlet weak var constraintHeightContainerChildren: NSLayoutConstraint!
    
    var childrenVC: SelectedChildrenAndTotalTableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "subscriptionConfirmation".localized()
        
        lblSubscriptionTitle.textColor = package.color
        lblSubscriptionSubtitle.textColor = UIColor.secondary
        
        btnPositive.setTitle("payNow".localized(), for: .normal)
        
        btnPositive.backgroundColor = UIColor.tint
        btnPositive.tintColor = UIColor.white
        
        lblSubscriptionTitle.text = package.title
        lblSubscriptionSubtitle.text = package.details
        
        
        if UIView.userInterfaceLayoutDirection(for: view.semanticContentAttribute) == .rightToLeft {
            btnPositive.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -16)
        }else {
            btnPositive.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnPositive.layer.cornerRadius = btnPositive.bounds.height / 2
        constraintHeightContainerChildren.constant = childrenVC?.tableView.contentSize.height ?? 300

    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectedChildren" {
            let vc = segue.destination as! SelectedChildrenAndTotalTableViewController
            
            childrenVC = vc
            vc.packageId = package.id
            vc.childIds = childIds
            vc.payment = payment
            
            vc.tableView.isScrollEnabled = false
            vc.tableView.separatorStyle = .none
            vc.view.layer.cornerRadius = 8
            vc.view.clipsToBounds = true
        }else if segue.identifier == "PaymentGateway" {
            let vc = segue.destination as! PaymentGatewayViewController
            vc.packageId = package.id
            vc.gateway = payment.id
            vc.childIds = childIds
        }
    }
    

}

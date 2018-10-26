//
//  CheckoutSubscriptionViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 9/9/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class CheckoutSubscriptionViewController: UIViewController {
    var package: Package!
    
    var paymentVC: PaymentTableViewController?
    var childSelectionVC: ChildSelectionViewController?
    
    var selectedChildren: [Child] = []
    var selectedPayment: PaymentItem?
    
    
    @IBOutlet weak var constraintHeightChild: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightPayment: NSLayoutConstraint!
    
    @IBOutlet weak var btnPositive: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "subscription".localized()
        
        btnPositive.backgroundColor = UIColor.tint
        btnPositive.tintColor = UIColor.white
        btnPositive.setTitle("next".localized(), for: .normal)
        
        togglePositiveAction(enabled: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        btnPositive.layer.cornerRadius = btnPositive.bounds.height / 2
    }

    var shouldEnablePositiveAction: Bool {
        return selectedChildren.count > 0 && selectedPayment != nil
    }
    func togglePositiveAction(enabled: Bool) {
        btnPositive.isEnabled = enabled
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChildsSegue" {
            let vc = segue.destination as! ChildSelectionViewController
            vc.delegate = self
//            vc.tableView.isScrollEnabled = false
            
            childSelectionVC = vc
            
            vc.view.layer.cornerRadius = 8
            vc.view.clipsToBounds = true
        }else if segue.identifier == "PaymentSegue" {
            let vc = segue.destination as! PaymentTableViewController
//            vc.tableView.isScrollEnabled = false
            vc.delegate = self
            
            paymentVC = vc
            
            vc.view.layer.cornerRadius = 8
            vc.view.clipsToBounds = true
            
        }else if segue.identifier == "CheckoutConfirmation" {
            let vc = segue.destination as! CheckoutConfirmationViewController
            vc.childIds = selectedChildren.reduce([], { (childIds, child) -> [Int32] in
                var childIds = childIds
                childIds.append(child.id)
                return childIds
            })
            
            vc.payment = selectedPayment!
            vc.package = package
        }
    }
    
    @IBAction func unwindToCheckout(_ sender: UIStoryboardSegue) {
        
    }

}

extension CheckoutSubscriptionViewController: ChildSelectionViewControllerDelegate {
    func childSelectionTableDidLayoutSubviews() {
        if childSelectionVC != nil {
            constraintHeightChild.constant = childSelectionVC!.tableView.contentSize.height
        }
    }
    
    func didSelect(child: Child) {
        selectedChildren.append(child)
        togglePositiveAction(enabled: shouldEnablePositiveAction)
    }
    
    func didDeselect(child: Child) {
        if let index = selectedChildren.index(of: child) {
            selectedChildren.remove(at: index)
        }
        togglePositiveAction(enabled: shouldEnablePositiveAction)
    }
}
extension CheckoutSubscriptionViewController: PaymentTableViewControllerDelegate {
    func paymentLayoutDidSubviews() {
        if paymentVC != nil {
            constraintHeightPayment.constant = paymentVC!.tableView.contentSize.height
        }
    }
    
    func didSelect(payment: PaymentItem) {
        selectedPayment = payment
        togglePositiveAction(enabled: shouldEnablePositiveAction)
    }
}

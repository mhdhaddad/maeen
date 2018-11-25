//
//  PaymentGatewayViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 9/14/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import WebKit

class PaymentGatewayViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicatorMessageLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var packageId: Int32!
    var childIds: [Int32] = []
    var gateway: String!
    
    var receivedGateway: Gateway?
    var isSuccessfulPayment = false
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleIndicatorView(withMessage: "loading".localized(), animating: true)
        Lookup.shared.subscribe(packageId: packageId, childIds: childIds, gateway: gateway, success: { [weak self] (gateway) in
            self?.receivedGateway = gateway
            
            let request = URLRequest(url: gateway.url)
            
            self?.webView.load(request)
            self?.webView.navigationDelegate = self
        }) { [weak self] (error) in
            self?.toggleIndicatorView(withMessage: error.localizedDescription, animating: false)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func toggleIndicatorView(withMessage message: String? = nil, animating: Bool = false) {
        
        if animating {
            indicator.startAnimating()
        }else {
            indicator.stopAnimating()
        }
        
        indicatorMessageLabel.text = message
        indicatorView.isHidden = message == nil
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PaymentConfirmation" {
            let vc = segue.destination as! PaymentConfirmationViewController
            vc.status = isSuccessfulPayment ? PaymentConfirmationViewController.StatusKind.success: PaymentConfirmationViewController.StatusKind.failure
            if let trackId = receivedGateway?.trackId {
                vc.trackId = trackId
            }
        }
    }
    

}
extension PaymentGatewayViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        guard let url = webView.url else {
            return
        }
        
        toggleIndicatorView(animating: false)
        
        switch url {
        case let sucess where sucess.lastPathComponent.elementsEqual("payment-info"):
            isSuccessfulPayment = true
            performSegue(withIdentifier: "PaymentConfirmation", sender: self)
        case let failure where failure.lastPathComponent.elementsEqual("payment-info-error"):
            isSuccessfulPayment = false
            performSegue(withIdentifier: "PaymentConfirmation", sender: self)
        default:
            break
        }
        
    }
}

//
//  AdviceDetailsViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 7/26/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import WebKit

class AdviceDetailsViewController: UIViewController {

    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var btnNegative: UIButton!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var visualView: UIVisualEffectView!
    
    var advice: Advice!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.startAnimating()
        Lookup.shared.advices(id: advice.id, childId: advice.childId, success: { [weak self] (attributes) in
            guard let html = attributes["data"] as? String else {
                return
            }
            self?.webView.loadHTMLString(html, baseURL: nil)
            self?.webView.navigationDelegate = self
        }) { [weak self] (error) in
            self?.indicator.stopAnimating()
            //TODO: handle error
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnNegative_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        visualView.layer.cornerRadius = visualView.layer.frame.height / 2
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
extension AdviceDetailsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        guard webView.url?.absoluteString != nil else {
            return
        }
        
        indicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("wk: fail: \(error.localizedDescription)")
        indicator.stopAnimating()
    }
}

//
//  EntryChildViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 6/9/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class EntryChildViewController: UIViewController {
    
    @IBOutlet weak var closeView: UIVisualEffectView!
    @IBOutlet weak var btnAddPhoto: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFamilyName: UILabel!
    
    @IBOutlet weak var lblSex: UILabel!
    
    @IBAction func btnClose_TouchUpinside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnAddPhoto.titleLabel?.font = UIFont.font(from: .action)
        
        if UIView.userInterfaceLayoutDirection(for: btnAddPhoto.semanticContentAttribute) == .rightToLeft {
            btnAddPhoto.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -35)
        }else {
            btnAddPhoto.titleEdgeInsets = UIEdgeInsets(top: 0, left: -35, bottom: 0, right: 0)
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeView.layer.cornerRadius = closeView.bounds.height / 2
    }
}

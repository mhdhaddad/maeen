//
//  HomeHeaderFooterView.swift
//  Maeen
//
//  Created by yahya alshaar on 7/26/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class HomeHeaderFooterView: UITableViewHeaderFooterView {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    var kind: ViewController.SectionKind!
    
    var delegate: HomeHeaderFooterViewDelegate?
    var isActionEnabled: Bool! {
        didSet {
            btnAction.isHidden = isActionEnabled
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.font = UIFont.font(from: .title1)
        btnAction.titleLabel?.font = UIFont.font(from: .secondryAction)
    }
    
    @IBAction func btnAction_TouchUpInside(_ sender: UIButton) {
        delegate?.didTriggerAction(kind: kind)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    static var nib: UINib = { UINib(nibName: identifier, bundle: nil) }()
    class var identifier: String {
        return "HomeHeaderFooterView"
    }
}
protocol HomeHeaderFooterViewDelegate {
    func didTriggerAction(kind: ViewController.SectionKind)
}

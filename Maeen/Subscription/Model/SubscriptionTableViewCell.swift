//
//  SubscriptionTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 8/12/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class SubscriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblChildernTitle: UILabel!
    @IBOutlet weak var lblChildern: UILabel!
    @IBOutlet weak var lblPackageTypeTitle: UILabel!
    @IBOutlet weak var lblPackageType: UILabel!
    @IBOutlet weak var lblStatusTitle: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblStartsAtTitle: UILabel!
    @IBOutlet weak var lblStartsAt: UILabel!
    @IBOutlet weak var lblExpiresAtTitle: UILabel!
    @IBOutlet weak var lblExpiresAt: UILabel!
    
    enum ContentKind: Int {
        case childName = 0
        case package = 1
        case status = 2
        case createdAt = 3
        case expiresAt = 4
        case renew = 5
    }
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var btnRenew: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for stack in stackView.subviews {
            
            let kind = ContentKind(rawValue: stack.tag)!
            if kind != .renew {
                let label = stack.subviews.first as? UILabel
                let value = stack.subviews.last as? UILabel
                
                label?.text = title(for: kind)
                label?.textColor = UIColor.primary
                label?.font = UIFont.font(from: .title2)
                
                value?.font = UIFont.font(from: .body)
                if UIView.userInterfaceLayoutDirection(for: stack.semanticContentAttribute) == .rightToLeft {
                    label?.textAlignment = .right
                    value?.textAlignment = .left
                }
            }
        }
        
        btnRenew.tintColor = UIColor.white
        btnRenew.layer.backgroundColor = UIColor.tint.cgColor
        btnRenew.setTitle("renew".localized(), for: .normal)
        btnRenew.setImage(#imageLiteral(resourceName: "renewalIcon"), for: .normal)
        btnRenew.imageView?.contentMode = .scaleAspectFit
        btnRenew.titleLabel?.font = UIFont.font(from: .action)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class var identifier: String {
        return "SubscriptionCell"
    }

    func title(for kind: ContentKind) -> String {
        switch kind {
            
        case .childName:
            return "childName".localized()
        case .package:
            return "package".localized()
        case .status:
            return "status".localized()
        case .createdAt:
            return "subscriptionCreatedAt".localized()
        case .expiresAt:
            return "subscriptionExpiresAt".localized()
        case .renew:
            return "renew".localized()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btnRenew.layer.cornerRadius = btnRenew.frame.height / 2
    }
    var subscription: Subscription! {
        didSet {
            
            lblChildern.text = subscription.childrenNames
            lblPackageType.text = subscription.type
            lblStartsAt.text = subscription.startsAt?.displayed
            lblExpiresAt.text = subscription.expiresAt?.displayed
            
            
            lblChildern.textColor = UIColor.secondary
            lblPackageType.textColor = UIColor.secondary
            lblStartsAt.textColor = UIColor.secondary
            lblExpiresAt.textColor = UIColor.secondary
            
            var status: String!
            var color: UIColor!
            if subscription.isValid {
               status = "valid".localized()
                color = UIColor.tintGreen
            }else {
                status = "expired".localized()
                color = UIColor.tintRed
            }
            
            lblStatus.text = status
            lblStatus.textColor = color
            
//            lblStatus.text = subscription.sta
//            for stack in stackView.subviews {
//                let lblValue = stack.subviews.last as? UILabel
//
//                var value: String?
//                switch ContentKind(rawValue: stack.tag)! {
//                case .childName:
//                    value = subscription.child
//                }
//            }
        }
    }
}

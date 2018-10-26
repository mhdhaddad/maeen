//
//  PaymentLogTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 8/27/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class PaymentLogTableViewCell: UITableViewCell {

    @IBOutlet weak var lblVoucherTitle: UILabel!
    @IBOutlet weak var lblVoucher: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblAmountTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDateTitle: UILabel!
    
    var payment: Payment! {
        didSet {
            lblVoucher.text = payment.id
            lblDate.text = payment.displayedDate
            lblAmount.text = payment.details
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblVoucherTitle.text = "voucherNumber".localized()
        lblAmountTitle.text = "amount".localized()
        lblDateTitle.text = "date".localized()
        
        lblVoucherTitle.textColor = UIColor.primary
        lblAmountTitle.textColor = UIColor.primary
        lblDateTitle.textColor = UIColor.primary
        
        lblVoucher.textColor = UIColor.secondary
        lblAmount.textColor = UIColor.secondary
        lblDate.textColor = UIColor.secondary
        
        
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
            lblVoucherTitle.textAlignment = .right
            lblAmountTitle.textAlignment = .right
            lblDateTitle.textAlignment = .right
            
            
            lblVoucher.textAlignment = .left
            lblAmount.textAlignment = .left
            lblDate.textAlignment = .left
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class var identifier: String {
        return "PaymentLogCell"
    }

}

//
//  ConsultationCollectionViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 8/5/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class ConsultationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblHint: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    class var identifier: String {
        return "ConsultationCell"
    }
    var consultation: Consultation! {
        didSet {
            let child = consultation.child
            
            lblName.text = child?.name
            imageView.sd_setImage(with: child?.imageURL, completed: nil)
            
            lblTitle.text = consultation.title
            lblDetails.text = consultation.snippet
            
            lblHint.text = consultation.since
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblName.textColor = UIColor.tint
        lblTitle.textColor = UIColor.tintGreen
        
        lblTitle.font = UIFont.font(from: .title2)
        lblHint.font = UIFont.font(from: .subTitle1)
        
        lblName.font = lblTitle.font
        lblDetails.font = UIFont.font(from: .body)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
}

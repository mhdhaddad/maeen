//
//  ConsultationTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 9/4/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class ConsultationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roundedContentView: ShadowView!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblSince: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var consultation: Consultation! {
        didSet {
            lblCategory.text = consultation.advice?.category
            lblTitle.text = consultation.title
            lblSubtitle.text = consultation.snippet
            lblSince.text = consultation.since
            avatarImageView.sd_setImage(with: consultation.child?.imageURL, placeholderImage: consultation.child?.placeholderImage, completed: nil)
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblCategory.textColor = UIColor.tint
        lblSince.textColor = UIColor.minor
        lblTitle.textColor = UIColor.tintGreen
        lblSubtitle.textColor = UIColor.secondary
        
        lblTitle.font = UIFont.font(from: .title2)
        lblSince.font = UIFont.font(from: .subTitle1)
        
        lblCategory.font = lblTitle.font
        lblSubtitle.font = UIFont.font(from: .body)

        
        avatarImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class var identifier: String {
        return "ConsultationCell"
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.layer.cornerRadius = avatarImageView.layer.frame.height / 2
    }
}

//
//  AdviceTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 8/31/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class AdviceTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblSince: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var roundedContentView: ShadowView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
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
        
    }

    var advice: Advice! {
        didSet {
            lblTitle.text = advice.title
            lblSubtitle.text = advice.snippet
            lblCategory.text = advice.category
            lblSince.text = advice.since
            lblRating.text = advice.displayedRating
            
            avatarImageView.sd_setImage(with: advice.child?.imageURL, placeholderImage: advice.child?.placeholderImage, completed: nil)
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class var identifier: String {
        return "AdviceTableViewCell"
    }
    static var nib: UINib = { UINib(nibName: identifier, bundle: nil) }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }
}

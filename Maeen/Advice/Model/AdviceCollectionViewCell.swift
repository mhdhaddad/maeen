//
//  AdviceCollectionViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 7/25/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class AdviceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblHint: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var advice: Advice! {
        didSet {
            let child = advice.child
            
            lblName.text = child?.name
//            imgView.image = #imageLiteral(resourceName: "childTestAvatar")
            imgView.sd_setImage(with: child?.imageURL, completed: nil)
            
            lblTitle.text = advice.title
            lblDetails.text = advice.snippet
            
            lblHint.text = advice.since
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        lblName.textColor = UIColor.tint
        lblTitle.textColor = UIColor.tintGreen
        lblDetails.textColor = UIColor.secondary
        lblHint.textColor = UIColor.minor
        
        lblTitle.font = UIFont.font(from: .title2)
        lblHint.font = UIFont.font(from: .subTitle1)
        
        lblName.font = lblTitle.font
        lblDetails.font = UIFont.font(from: .body)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = imgView.frame.width / 2
    }
}

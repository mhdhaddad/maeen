//
//  ChildCollectionViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 7/26/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import SDWebImage

class ChildCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    var child: Child! {
        didSet {
            lblName.text = child.name

            lblAge.text = child.displayedAge
            imgView.sd_setImage(with: child.imageURL, placeholderImage: child?.placeholderImage, completed: nil)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 8.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        lblName.font = UIFont.font(from: .title2)
        lblAge.font = UIFont.font(from: .body)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = imgView.frame.height / 2
        
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
}

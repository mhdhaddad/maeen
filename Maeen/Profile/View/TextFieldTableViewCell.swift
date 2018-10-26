//
//  TextFieldTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 9/29/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textFiled: UITextField!
    
    var item: EntryItem! {
        didSet {
            titleLabel.text = item.title
            textFiled.text = item.value?.rawValue as? String
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = UIColor.primary
        textFiled.textColor = UIColor.secondary
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

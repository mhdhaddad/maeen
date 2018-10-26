//
//  PlainTextFieldTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 10/6/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class PlainTextFieldTableViewCell: UITableViewCell {
    @IBOutlet weak var textField: UITextField!
    
    var entry: EntryItem! {
        didSet {
            textField.placeholder = entry.title
            textField.text = entry.value?.displayed
            
        }
    }
    var isTextEntry: Bool! {
        didSet {
            textField.isUserInteractionEnabled = isTextEntry
            selectionStyle = isTextEntry ? .none: .default
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class var identifier: String {
        return "PlainTextFieldTableViewCell"
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    @IBAction func textField_EditingChanged(_ sender: UITextField) {
        if let value = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            entry.value = EntryValue(value: value)
        }else {
            entry.value = nil
        }
    }
    
}

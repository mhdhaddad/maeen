//
//  TextFieldEntryItemCell.swift
//  Maeen
//
//  Created by yahya alshaar on 5/24/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class TextFieldEntryItemCell: EntryItemCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var txtValue: UITextField!
    
    var delegate: TextFieldEntryItemCellDelegate?
    
    override var entry: EntryItem! {
        didSet {
            txtValue.placeholder = entry.title
            if let iconNamed = entry.icon {
                iconImageView.image = UIImage(named: iconNamed)
            }
        }
    }
    
    class var identifier: String {
        return "TextFieldEntryItemCell"
    }
    static var nib: UINib = { UINib(nibName: identifier, bundle: nil) }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtValue.addTarget(self, action: #selector(textFieldDidChanged(textField:)), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChanged(textField: UITextField) {
        
        var option: EntryValue? = nil
        if let text = textField.text {
            option = EntryValue(value: text)
        }
        
        entry.value = option
        delegate?.textFieldDidChange(textField: textField, kind: entry.kind)
    }
}

protocol TextFieldEntryItemCellDelegate: class {
    func textFieldDidChange(textField: UITextField, kind: EntryItem.Kind)
    func textFieldShouldReturn(textField: UITextField) -> Bool
}

extension TextFieldEntryItemCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldReturn(textField: textField) ?? true
    }
}

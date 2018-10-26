//
//  PickerTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 10/12/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class PickerTableViewCell: UITableViewCell {

    var options: [EntryOption] = [] {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    var delegate: PickerTableViewCellDelegate?
    
    @IBOutlet weak var pickerView: UIPickerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.dataSource = self
        pickerView.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
protocol PickerTableViewCellDelegate {
    func didSelectValue(atIndex index: Int, option: EntryOption)
}
extension PickerTableViewCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return options.count > 0 ? 1: 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row].displayed
    }
    
}
extension PickerTableViewCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.didSelectValue(atIndex: row, option: options[row])
    }
}

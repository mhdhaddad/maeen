//
//  DatePickerTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 10/13/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {

    var date: Date?
    var delegate: DatePickerTableViewCellDelegate?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func datePicker_ValueChanged(_ sender: UIDatePicker) {
        delegate?.didSelectDate(sender.date)
    }
    
}
protocol DatePickerTableViewCellDelegate {
    func didSelectDate(_ date: Date)
}

//
//  EmailViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 5/26/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class EmailViewController: UITableViewController {
    var entries: [EntryItem] = [
        EntryItem(key: "email", kind: .email, icon: "email")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "whatIsYourEmail".localized()
        setupTableView()
    }
    var delegate: WelcomingStageViewContainerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupTableView() {
        tableView.register(TextFieldEntryItemCell.nib, forCellReuseIdentifier: TextFieldEntryItemCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prepareStyleOnBoarding()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldEntryItemCell.identifier, for: indexPath) as! TextFieldEntryItemCell
        cell.entry = entries[indexPath.row]
        cell.delegate = self
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
extension EmailViewController: TextFieldEntryItemCellDelegate {
    func textFieldDidChange(textField: UITextField, kind: EntryItem.Kind) {
        let value = textField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let isValid = EntryValidation.isValidEmail(email: value)
        
        
        if isValid {
            entries[0].value = EntryValue(value: value)
            delegate?.enablePositiveAction()
        }else {
            entries[0].value = nil
            delegate?.disablePositiveAction()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    
}
//extension EmailViewController: WelcomingStageViewContainerDelegate {
//    func didTriggerPositiveAction() {
//
//
//    }
//}

//
//  PasswordViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 5/25/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

///
/// Deprecated
///

class PasswordViewController: UITableViewController {
    var entries: [EntryItem] = [
        EntryItem(key: "password", kind: .password, icon: "password")
    ]
    
    var delegate: WelcomingStageViewContainerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "setAPassword".localized()
        
        setupTableView()
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
extension PasswordViewController: TextFieldEntryItemCellDelegate {
    func textFieldDidChange(textField: UITextField, kind: EntryItem.Kind) {
        
        let isValid = textField.text?.count ?? 0 > 5
        if isValid {
//            entries[0].value = textField.text
        }else {
            entries[0].value = nil
        }
//        parent?.isKind(of: WelcomingStageViewContainer) as?
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
}

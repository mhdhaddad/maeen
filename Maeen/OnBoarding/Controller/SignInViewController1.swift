//
//  SignInViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 5/23/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class SignInViewController1: UITableViewController {
 
    enum SignInContext {
        case phonenumber
        case email
    }
    var entries = [
        EntryItem(key: "", kind: .text, icon: nil, title: "signInWithEmailOrPhonenumber".localized())
//        EntryItem(key: "password", kind: .password, icon: "password")
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    private func setupTableView() {
        tableView.register(TextFieldEntryItemCell.nib, forCellReuseIdentifier: TextFieldEntryItemCell.identifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return entries.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldEntryItemCell.identifier, for: indexPath) as! TextFieldEntryItemCell
        cell.entry = entries[indexPath.section]
        return cell
        
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return entries[section].title
    }
    
    func process() {
        guard let value = entries[0].value?.rawValue as? String else {
            return
        }
        
        if value.contains("@") || value.contains(".") {
            
        }
    }
}
extension SignInViewController1: TextFieldEntryItemCellDelegate {
    func textFieldDidChange(textField: UITextField, kind: EntryItem.Kind) {
        let text = textField.text
        
        guard text != nil else {
            return
        }
        
        
        if text!.contains("@") || text!.contains(".") {
            
        }else {
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return false
    }
    
    
}

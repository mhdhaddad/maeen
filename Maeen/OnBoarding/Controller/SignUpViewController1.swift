//
//  SignUpViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 5/23/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class SignUpViewController1: UITableViewController {
    var entries: [EntryItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(TextFieldEntryItemCell.nib, forCellReuseIdentifier: TextFieldEntryItemCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
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
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

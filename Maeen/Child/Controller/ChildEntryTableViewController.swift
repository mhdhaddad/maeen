//
//  ChildEntryTableViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 10/6/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import JGProgressHUD

class ChildEntryTableViewController: UITableViewController {
    
    var entries: [EntryItem] = []
    var optionsPickerIndexPath: IndexPath?
    var kindForSelectedEntry: EntryItem.Kind?
    
    var values: [EntryValue] = []
    
    let siblingOptions: [EntryValue] = {
        var values: [EntryValue] = []
        for value in 0...15 {
            values.append(EntryValue(value: value))
        }
        
        return values
    }()
    
    let genderOptions = [
        EntryValue(value: "M", displayed: "male".localized()),
        EntryValue(value: "F", displayed: "female".localized())
    ]
    
    
    let relationOptions = [
        EnumValue(Child.Relationship.sun),
        EnumValue(Child.Relationship.brother),
        EnumValue(Child.Relationship.grandson),
        EnumValue(Child.Relationship.student),
        EnumValue(Child.Relationship.friend),
        EnumValue(Child.Relationship.neighbor)
        
    ]
    
    let dateFormatter: DateFormatter! = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }(
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "addChild".localized()
        
        setupTableView()
        
        entries = [
            EntryItem(key: "first_name", kind: .firstName, icon: nil, title: "firstName".localized()),
            EntryItem(key: "last_name", kind: .lastName, icon: nil, title: "lastName".localized()),
            EntryItem(key: "gender", kind: .sex, icon: nil, title: "sex".localized(), value: genderOptions.first),
            EntryItem(key: "birthdate", kind: .dateOfBirth, icon: nil, title: "dateOfBirth".localized()),
            EntryItem(key: "relationship_id", kind: .relationship, icon: nil, title: "relationship".localized(), value: relationOptions.first),
            EntryItem(key: "siblings", kind: .numberOfSibling, icon: nil, title: "siblings".localized(), value: siblingOptions.first),
            
            
        ]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    let nonTextEntries: [EntryItem.Kind] = [.sex, .dateOfBirth, .relationship, .numberOfSibling]
    func isTextEntry(kind: EntryItem.Kind) -> Bool {
        return nonTextEntries.contains(kind) == false
    }
    private func setupTableView() {
        tableView.register(PlainTextFieldTableViewCell.nib, forCellReuseIdentifier: PlainTextFieldTableViewCell.identifier)
        tableView.register(PlainHeaderTableView.nib, forHeaderFooterViewReuseIdentifier: PlainHeaderTableView.identifier)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pickerIndexPath = optionsPickerIndexPath {
            if pickerIndexPath.section == section {
                return 2 // by default the number of rows is 1, but in case picker cell exsit
            }
        }
        
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if optionsPickerIndexPath != nil && optionsPickerIndexPath!.row == indexPath.row {
            
            if kindForSelectedEntry == .dateOfBirth {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell", for: indexPath) as! DatePickerTableViewCell
                
                cell.date = dateFormatter.date(from: entries[indexPath.section].value?.rawValue as? String ?? "")
                cell.delegate = self
                
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath) as! PickerTableViewCell
                cell.delegate = self
                var values: [EntryOption] = []
                
                switch kindForSelectedEntry! {
                case .numberOfSibling:
                    values = siblingOptions
                case .sex:
                    values = genderOptions
                case .relationship:
                    values = relationOptions
                default:
                    break
                }
                
                
                cell.options = values
                return cell
            }
        }else {
            let entry = entries[indexPath.section]
            let cell = tableView.dequeueReusableCell(withIdentifier: PlainTextFieldTableViewCell.identifier, for: indexPath) as! PlainTextFieldTableViewCell
            cell.entry = entry
            
            cell.isTextEntry = isTextEntry(kind: cell.entry.kind)
            return cell
        }
    }
    func validateEntries() -> Bool {
        var isValid = true
        
        for entry in entries {
            if isValid == false {
                break
            }
            
            switch entry.kind! {
            case .firstName, .lastName, .sex, .numberOfSibling, .dateOfBirth, .relationship:
                isValid = entry.value?.rawValue != nil
            default:
                break
            }
        }
        
        return isValid
    }
    
    @IBAction func btnPositive_TouchUpInside(_ sender: Any) {
        guard validateEntries() else {
            let alert = UIAlertController(title: "errorFieldsRequired".localized(), message: "requiredFieldsMessage".localized(), preferredStyle: .alert)
            let action = UIAlertAction(title: "ok".localized(), style: .default, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let indicator = JGProgressHUD(style: .dark)
        indicator.textLabel.text = "loading".localized()
        indicator.show(in: self.view)
        
        Lookup.shared.addChild(attributes: entries.paramters, success: { (child) in
            UIView.animate(withDuration: 0.1, animations: {
                indicator.textLabel.text = "successfullySent".localized()
                indicator.indicatorView = JGProgressHUDSuccessIndicatorView()
            })
            
            indicator.dismiss(afterDelay: 1.0)
            self.dismiss(animated: true, completion: nil)
        }) { (error) in
            UIView.animate(withDuration: 0.1, animations: {
                indicator.textLabel.text = "failedToSend".localized()
                indicator.indicatorView = JGProgressHUDErrorIndicatorView()
            })
            
            indicator.dismiss(afterDelay: 2.0)
        }
    }
    @IBAction func btnNegative_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: PlainHeaderTableView.identifier) as! PlainHeaderTableView
        cell.titleLabel.text = entries[section].title
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let kind = entries[indexPath.section].kind!
        switch kind {
        case .sex, .numberOfSibling, .dateOfBirth, .relationship:
            togglePicker(indexPath: indexPath, withKind: kind)
        default:
            break
        }
    }
    
    
    
    // MARK: - Picker cell handling
    
    func togglePicker(indexPath: IndexPath, withKind kind: EntryItem.Kind) {
        kindForSelectedEntry = kind
        
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        if optionsPickerIndexPath != nil && optionsPickerIndexPath!.row - 1 == indexPath.row { // case 2
            tableView.deleteRows(at: [optionsPickerIndexPath!], with: .fade)
            self.optionsPickerIndexPath = nil
        }else { // case 1,3
            
            if optionsPickerIndexPath != nil {
                tableView.deleteRows(at: [optionsPickerIndexPath!], with: .fade)
                
            }
            
            optionsPickerIndexPath = calculateOptionsPickerIndexPath(indexPathSelected: indexPath)
            tableView.insertRows(at: [self.optionsPickerIndexPath!], with: .fade)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
    
    func calculateOptionsPickerIndexPath(indexPathSelected: IndexPath) -> IndexPath {
        if optionsPickerIndexPath != nil && optionsPickerIndexPath!.row  < indexPathSelected.row { // case 3.2
            return IndexPath(row: indexPathSelected.row, section: indexPathSelected.section)
        } else { // case 1、3.1
            return IndexPath(row: indexPathSelected.row + 1, section: indexPathSelected.section)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
//    func creatDate(string: String) -> Date {
//
//    }
}

extension ChildEntryTableViewController: PickerTableViewCellDelegate {
    func didSelectValue(atIndex index: Int, option: EntryOption) {
        guard let kind = kindForSelectedEntry else {
            return
        }
        
        if let section = entries.index(where: { (item) -> Bool in
            return item.kind == kind
        }) {
            entries[section].value = option
            
            
            UIView.setAnimationsEnabled(false)
            let indexPath = IndexPath(row: 0, section: section)
            tableView.reloadRows(at: [indexPath], with: .none)
            UIView.setAnimationsEnabled(true)
        }
    }
}

extension ChildEntryTableViewController: DatePickerTableViewCellDelegate {
    func didSelectDate(_ date: Date) {
        guard let kind = kindForSelectedEntry else {
            return
        }
        
        if let section = entries.index(where: { (item) -> Bool in
            return item.kind == kind
        }) {
            entries[section].value = EntryValue(value: dateFormatter.string(from: date))
            
            UIView.setAnimationsEnabled(false)
            let indexPath = IndexPath(row: 0, section: section)
            tableView.reloadRows(at: [indexPath], with: .none)
            UIView.setAnimationsEnabled(true)
        }
    }
}

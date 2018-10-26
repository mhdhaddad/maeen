//
//  CommonTableViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 6/9/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class CommonTableViewController: UITableViewController {
    
    var strings = [""] {
        didSet {
            setupData()
        }
    }
    
    
    enum SupportKind {
        case supportInsertion
        case supportInsertionIfNoData
        case none
    }
    var kind: SupportKind = .none
    var defaultValue: String?
//    var otherEntry: EntryItem = { EntryItem(key: "other") }()
    
    enum SectionKind {
        case text
        case insertion
    }
    var sections: [SectionKind]!
    
    
    var identifier: Int = 0
    
    private var data = [TitleAndIndexTuple]()
    private var filterdData = [TitleAndScoreTuple]()
    
    var observer: Notification.Name?
    
    typealias TitleAndIndexTuple = (title: String, index: Int)
    typealias TitleAndScoreTuple = (tuple: TitleAndIndexTuple, score:Double)
    
    var delegate: CommonTableViewControllerDelegate?
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch kind {
        case .supportInsertion, .supportInsertionIfNoData:
            sections = [.text, .insertion]
        case .none:
            sections = [.text]
        }
        
        setupTableView()
        setupNavigationController()
        
//        if let value = defaultValue {
//            if strings.contains(value) == false {
//                otherEntry.value = EntryItem.Value(raw: value, displayed: nil)
//
//                tableView.reloadSections(IndexSet(integer: 1), with: .none)
//            }
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNotification(notification:)), name: observer, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didReceiveNotification(notification: Notification) {
        if let titles = notification.object as? [String] {
            strings = titles
            tableView.reloadData()
        }
    }
    func setupData() {
        guard strings.count > 0 else {
            return
        }
        for i in 0...strings.count - 1 {
            data.append((title: strings[i], index: i))
        }
        
    }
    
    private func setupTableView() {
        tableView.register(LabelTableViewCell.nib, forCellReuseIdentifier: LabelTableViewCell.identifer)
//        tableView.register(EntryByTextFieldCell.nib, forCellReuseIdentifier: EntryByTextFieldCell.identifier)
        //        switch kind {
        //        case .supportInsertion:
        //            tableView.style = .grouped
        //        default:
        //            tableView.style = .plain
        //        }
    }
    private func setupNavigationController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .text:
            if isFiltering() {
                return filterdData.count
            }
            return data.count
        default:
            switch kind {
            case .supportInsertionIfNoData where strings.count > 0:
                return 0
            default :
                return 1
            }
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifer, for: indexPath) as! LabelTableViewCell
            cell.lblTitle.text = isFiltering() ? filterdData[indexPath.row].tuple.title : data[indexPath.row].title
            cell.lblTitle.textColor = UIColor.primary
            return cell
        case .insertion:
            return UITableViewCell()
        }
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch sections[indexPath.section] {
        case .text:
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            if isFiltering() {
                delegate?.didSelectItemAt(index: filterdData[indexPath.row].tuple.index, with: identifier, andValue: filterdData[indexPath.row].tuple.title)
            }else {
                delegate?.didSelectItemAt(index: data[indexPath.row].index, with: identifier, andValue: data[indexPath.row].title)
            }
            
            popViewController()
        default:
            break
        }
        
        
    }
    
    func popViewController() {
        DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 0.4), execute: {
            self.navigationController?.popViewController(animated: true)
        })
    }
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    func filterContentForSearchText(_ searchText: String) {
        var results = [TitleAndScoreTuple]()
        
        for tuple in data {
            let score = tuple.title.score(word: searchText, fuzziness: 0.4)
            
            let t = (tuple: tuple, score: score)
            results.append(t)
        }
        results = results.filter { (title, score) -> Bool in
            return score > 0.3
        }
        filterdData = results.sorted { (t1, t2) -> Bool in
            return t1.score > t2.score
        }
        
    }
}
protocol CommonTableViewControllerDelegate: class {
    func didSelectItemAt(index: Int, with pageIdentifier: Int, andValue value: String)
    func didAddItem(_ value: String, forIdentifier identifier: Int)
}

extension CommonTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text ?? "")
        tableView.reloadData()
    }
}

//extension CommonTableViewController: TextFieldEntryTableViewCellDelegate {
//    func textFieldDidChange(textField: UITextField, kind: EntryItem.Kind) {
//
//    }
//
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        print("textFieldShouldReturn")
//        if let text = textField.text, text.isEmpty == false {
//            delegate?.didAddItem(text, forIdentifier: identifier)
//            popViewController()
//        }else {
//            //todo: dismiss keyboard
//        }
//
//        return true
//    }
//
//
//}

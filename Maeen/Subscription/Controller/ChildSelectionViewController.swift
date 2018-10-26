//
//  ChildSelectionViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 9/10/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import CoreData

protocol ChildSelectionViewControllerDelegate {
    func didSelect(child: Child)
    func didDeselect(child: Child)
    func childSelectionTableDidLayoutSubviews()
}

class ChildSelectionViewController: UITableViewController {

    @IBOutlet weak var headerLabelView: UILabel!
    
    var fetchedResultsController: NSFetchedResultsController<Child>!
    var delegate: ChildSelectionViewControllerDelegate?
    var selectedIndexPaths: [IndexPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        initializeFetchedResultsController()
        headerLabelView.text = "selectChildForSubsecribtionHeader".localized()
    }

    func initializeFetchedResultsController() {
        let request: NSFetchRequest<Child> = Child.fetchRequest()
        let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
        request.sortDescriptors = [nameSort]
        request.fetchBatchSize = 25
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: app.handler.moc, sectionNameKeyPath: nil, cacheName: nil)
//        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultsController.sections![section].numberOfObjects
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BriefChildTableViewCell.identifier, for: indexPath) as! BriefChildTableViewCell
        cell.child = fetchedResultsController.object(at: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(child: fetchedResultsController.object(at: indexPath))
        
        tableView.cellForRow(at: indexPath)?.isSelected = true
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        delegate?.didDeselect(child: fetchedResultsController.object(at: indexPath))
        
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "selectChildForSubsecribtionHeader".localized()
//    }
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let headerView = tableView.tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            var headerFrame = headerView.frame
            
            //Comparison necessary to avoid infinite loop
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
        
        delegate?.childSelectionTableDidLayoutSubviews()
    }
}


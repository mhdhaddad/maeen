//
//  AdviceTableViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 7/26/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import CoreData

class AdviceTableViewController: UITableViewController {
    var childId: Int32?
    var dialogView: DialogActionView?
    
    var fetchedResultsController: NSFetchedResultsController<Advice>!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        initializeFetchedResultsController()
        
        tableView.register(AdviceTableViewCell.nib, forCellReuseIdentifier: AdviceTableViewCell.identifier)
        tableView.dataSource = self
    }

    func initializeFetchedResultsController() {
        let request: NSFetchRequest<Advice> = Advice.fetchRequest()
        let sort = NSSortDescriptor(key: "createdAt", ascending: true)
        if childId != nil {
            request.predicate = NSPredicate(format: "childId == %i", childId!)
        }
        request.sortDescriptors = [sort]
        request.fetchBatchSize = 25
        
        
        let moc = app.handler.moc
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
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

    private func toggleDialogActionView(enabled: Bool) {
        if enabled == false {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
        }else {
            if dialogView == nil {
                dialogView = DialogActionView.loadFromNib(msg: "emptyAdviceMessage".localized().capitalized, action: "startExploring".localized().uppercased(), icon: #imageLiteral(resourceName: "empty"), delegate: nil)
            }
            
            tableView.backgroundView  = dialogView
            tableView.separatorStyle  = .none
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        toggleDialogActionView(enabled: fetchedResultsController.fetchedObjects?.count ?? 0 < 1)
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.sections![section].numberOfObjects
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdviceTableViewCell.identifier, for: indexPath) as! AdviceTableViewCell
        cell.advice = fetchedResultsController.object(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "PresentAdviceDetails", sender: self)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "PresentAdviceDetails" {
            let vc = segue.destination as! AdviceDetailsViewController
            if let indexPath = tableView.indexPathForSelectedRow {
            vc.advice = fetchedResultsController.object(at: indexPath)
                
            }
            
        }
    }
    

}

extension AdviceTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
        UIView.setAnimationsEnabled(false)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .bottom)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .top)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .bottom)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .top)
        case .update:
            break
            
        //                    tableView.reloadRows(at: [indexPath!], with: .none)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        
        
    }
}

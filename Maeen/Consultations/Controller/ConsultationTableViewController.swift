//
//  ConsultationTableViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 6/29/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import CoreData

class ConsultationTableViewController: UITableViewController {

    var fetchedResultsController: NSFetchedResultsController<Consultation>!
    var childId: Int32?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        initializeFetchedResultsController()
    }
    
    func initializeFetchedResultsController() {
        let request: NSFetchRequest<Consultation> = Consultation.fetchRequest()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowConsultationDetails" {
            let vc = segue.destination as! ConsultationDetailsViweController
            vc.consultation = (sender as! ConsultationTableViewCell).consultation
            
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConsultationTableViewCell.identifier, for: indexPath) as! ConsultationTableViewCell
        cell.consultation = fetchedResultsController.object(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension ConsultationTableViewController: NSFetchedResultsControllerDelegate {
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

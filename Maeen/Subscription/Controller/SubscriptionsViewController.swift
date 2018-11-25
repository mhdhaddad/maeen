//
//  SubscriptionsViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 8/12/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import CoreData

class SubscriptionsViewController: UIViewController {

    @IBOutlet weak var btnPackages: UIButton!
    @IBOutlet weak var btnPaymentLog: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblAdvicesCount: UILabel!
    @IBOutlet weak var lblConsultationCount: UILabel!
    @IBOutlet weak var lblChildrenCount: UILabel!
    
    var subscriptions: [Subscription] = []
    
    var fetchedResultsController: NSFetchedResultsController<Subscription>!
    
    func initializeFetchedResultsController() {
        let request: NSFetchRequest<Subscription> = Subscription.fetchRequest()
        let nameSort = NSSortDescriptor(key: "startsAt", ascending: true)
        request.sortDescriptors = [nameSort]
        request.fetchBatchSize = 25
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: app.handler.moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "subscriptions".localized()
        
        lblAdvicesCount.font = UIFont.font(from: .title2)
        lblChildrenCount.font = UIFont.font(from: .title2)
        lblConsultationCount.font = UIFont.font(from: .title2)
        
        
        lblConsultationCount.textColor = UIColor.white
        lblChildrenCount.textColor = UIColor.white
        lblAdvicesCount.textColor = UIColor.white
        
        btnPackages.tintColor = UIColor.white
        btnPackages.layer.backgroundColor = UIColor.tintOrange.cgColor
        
        btnPaymentLog.tintColor = UIColor.white
        btnPaymentLog.layer.backgroundColor = UIColor.tintOrange.cgColor
        
        btnPackages.setTitle("packages".localized(), for: .normal)
        btnPackages.setImage(#imageLiteral(resourceName: "packagesIcon"), for: .normal)
        btnPackages.imageView?.contentMode = .scaleAspectFit
        btnPackages.titleLabel?.font = UIFont(name: AdirBold, size: 14)!
        
        btnPaymentLog.setTitle("paymentLog".localized(), for: .normal)
        btnPaymentLog.setImage(#imageLiteral(resourceName: "paymentLogIcon"), for: .normal)
        btnPaymentLog.imageView?.contentMode = .scaleAspectFit
        btnPaymentLog.titleLabel?.font = UIFont(name: AdirBold, size: 14)!
        
        initializeFetchedResultsController()
        fetchSubscription()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let user = app.account.user
        
        lblAdvicesCount.text = user?.displayedAdvicesCount
        lblConsultationCount.text = user?.displayedConsulatationsCount
        lblChildrenCount.text = user?.displayedChildrenCount
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnPackages.layer.cornerRadius = btnPackages.frame.height / 2
        btnPaymentLog.layer.cornerRadius = btnPaymentLog.frame.height / 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "renewSubscription".localized()
    }
    
    @IBAction func unwindToSubscribtions(_ sender: UIStoryboardSegue) {
        fetchSubscription()
    }
    
    func fetchSubscription() {
        Lookup.shared.subscriptions(context: app.handler.moc, success: { (subscriptions) in
            app.handler.saveContext()
        }) { (error) in
            //TODO: handle error
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

}
extension SubscriptionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubscriptionTableViewCell.identifier, for: indexPath) as! SubscriptionTableViewCell
            cell.subscription = fetchedResultsController.object(at: indexPath)
        return cell
    }
}
extension SubscriptionsViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
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
            
        //            tableView.reloadRows(at: [indexPath!], with: .none)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

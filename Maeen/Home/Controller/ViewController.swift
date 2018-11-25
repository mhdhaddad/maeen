//
//  ViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 5/23/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var sections: [SectionKind] = [.advices, .consultations]
    var fetchedResultsController: NSFetchedResultsController<HomeContainer>!
    enum SectionKind: String {
        case advices = "adviceSectionTitle"
        case consultations = "consultationSectionTitle"
    }
    
    var advices:[Advice] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var consultations: [Consultation] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnWelcome: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "home".localized()
        btnWelcome.setTitle("Welcome Sign in | Sign up", for: .normal)
        
        tableView.register(HomeHeaderFooterView.nib, forHeaderFooterViewReuseIdentifier: HomeHeaderFooterView.identifier)
        tableView.register(EmptyStautsFooterView.nib, forHeaderFooterViewReuseIdentifier: EmptyStautsFooterView.identifier)
        
        initializeFetchedResultsController()
        
        if app.account.isGeust {
            Lookup.shared.auth(username: "test08@maeen.org", password: "password", success: { (attributes) in
                
                app.account.authentication(attributes: attributes)
            }) { (error) in
                print(error)
            }
        }else {
            // sync up with childs
            Lookup.shared.childs(context: app.handler.moc, success: { (childs) in
                app.handler.saveContext()
            }) { (error) in
                
            }
            
            Lookup.shared.advices(context: app.handler.moc, success: { (advices, context) in
                app.account.user?.advicesCount = context.total
                app.handler.saveContext()
            }) { (error) in
                //TODO: handel error
            }
            
            Lookup.shared.consultations(context: app.handler.moc, success: { (consultations, context) in
                app.account.user?.consultationsCount = context.total
                app.handler.saveContext()
            }) { (error) in
                //TODO: handle error
            }
        }
    }
    
    func initializeFetchedResultsController() {
        let request: NSFetchRequest<HomeContainer> = HomeContainer.fetchRequest()
//        let sort = NSSortDescriptor(key: "createdAt", ascending: true)
        let sortSection = NSSortDescriptor(key: "section", ascending: true)
        
        request.sortDescriptors = [sortSection]
        request.fetchBatchSize = 25

        
        let moc = app.handler.moc
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: "section", cacheName: "Root")
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AdviceDetailsSegue" {
            let vc = segue.destination as! AdviceDetailsViewController
            let cell =  sender as! AdviceCollectionViewCell
            vc.advice = cell.advice
        }else if segue.identifier == "ShowAllAdvices" {
            let vc = segue.destination
            vc.title = "adviceSectionTitle".localized()
        }else if segue.identifier == "ShowAllConsultations" {
            let vc = segue.destination
            vc.title = "consultationSectionTitle".localized()
        }else if segue.identifier == "consultationDetails" {
            let vc = segue.destination as! ConsultationDetailsViweController
            vc.consultation = (sender as! ConsultationCollectionViewCell).consultation
        }
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        
        guard sections.count > section else {
            return 0
        }
        return sections[section].numberOfObjects > 0 ? 1: 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if fetchedResultsController.object(at: indexPath).isKind(of: Advice.self) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdviceCollectionCell", for: indexPath) as! AdviceCollectionTableViewCell
            cell.advices = fetchedResultsController.sections![indexPath.section].objects as! [Advice]
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConsultationCollectionCell", for: indexPath) as! ConsultationCollectionTableViewCell
            cell.consultations = fetchedResultsController.sections![indexPath.section].objects as! [Consultation]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let kind = sections[section]
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderFooterView.identifier) as! HomeHeaderFooterView
        view.lblTitle.text = kind.rawValue.localized()
        view.kind = kind
        view.btnAction.setTitle("seeAll".localized(), for: .normal)
        
        view.isActionEnabled = isEmpty(section: section)
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard isEmpty(section: section) else {
            return nil
        }
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: EmptyStautsFooterView.identifier) as! EmptyStautsFooterView
        
        switch sections[section] {
        case .advices:
            view.message = "emptyAdvicesMessage".localized()
        case .consultations:
            view.message = "emptyConsultationsMessage".localized()
        }
        
        return view
    }
    
    func isEmpty(section: Int) -> Bool {
        var isEmptySection = true
        
        if let fetchedSections = fetchedResultsController.sections {
            if fetchedSections.count > section {
                if fetchedSections[section].numberOfObjects > 0 {
                    isEmptySection = false
                }
            }
        }
        
        return isEmptySection
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return isEmpty(section: section) ? 200: 0
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
extension ViewController: HomeHeaderFooterViewDelegate {
    func didTriggerAction(kind: SectionKind) {
        switch kind {
        case .advices:
            performSegue(withIdentifier: "ShowAllAdvices", sender: self)
        case .consultations:
            performSegue(withIdentifier: "ShowAllConsultations", sender: self)
        }
    }
}
extension ViewController: NSFetchedResultsControllerDelegate {
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//    }
    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//        switch type {
//        case .insert:
//            tableView.insertSections(IndexSet(integer: sectionIndex), with: .bottom)
//        case .delete:
//            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .top)
//        case .move:
//            break
//        case .update:
//            break
//        }
//    }
//    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            tableView.insertRows(at: [newIndexPath!], with: .bottom)
//        case .delete:
//            tableView.deleteRows(at: [indexPath!], with: .top)
//        case .update:
//            break
//            
//        //            tableView.reloadRows(at: [indexPath!], with: .none)
//        case .move:
//            tableView.moveRow(at: indexPath!, to: newIndexPath!)
//        }
//    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
//        tableView.endUpdates()
    }
}

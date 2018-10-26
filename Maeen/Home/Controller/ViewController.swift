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
    
    var sections: [SectionKind] = [.advices, .consultations]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "home".localized()
        btnWelcome.setTitle("Welcome Sign in | Sign up", for: .normal)
        
        tableView.register(HomeHeaderFooterView.nib, forHeaderFooterViewReuseIdentifier: HomeHeaderFooterView.identifier)
        
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
//                for child in childs {
//                    let request: NSFetchRequest<Child> = Child.fetchRequest()
//
//                    request.predicate = NSPredicate(format: "id == %i", child.id)
//
//                    if try! app.handler.moc.count(for: request as! NSFetchRequest<NSFetchRequestResult>) == 0 {
//                        child.insert(into: app.handler.moc)
//                    }
//                }
                app.handler.saveContext()
            }) { (error) in
                
            }
            
//            Lookup.shared.advices(context: app.handler.moc, success: { (advices) in
//                self.advices = advices
//                app.handler.saveContext()
//            }) { (error) in
//                //TODO: handle error
//            }

            
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
            
//            Lookup.shared.advices(context: nil, success: { (advices) in
//                self.advices = advices
//                for advice in advices {
//
//                    let request: NSFetchRequest<Advice> = Advice.fetchRequest()
//
//                    request.predicate = NSPredicate(format: "id == %i", advice.id)
//
//                    if try! app.handler.moc.count(for: request as! NSFetchRequest<NSFetchRequestResult>) == 0 {
//                        advice.insert(into: app.handler.moc)
//                    }
//
//                }
//                app.handler.saveContext()
//            }) { (error) in
//                //TODO: handel error
//            }
            
//            Lookup.shared.consultations(success: { (consultations) in
//                self.consultations = consultations
//                for consultation in consultations {
//
//                    let request: NSFetchRequest<Consultation> = Consultation.fetchRequest()
//
//                    request.predicate = NSPredicate(format: "id == %i", consultation.id)
//
//                    if try! app.handler.moc.count(for: request as! NSFetchRequest<NSFetchRequestResult>) == 0 {
//                        consultation.insert(into: app.handler.moc)
//                    }
//                }
//                app.handler.saveContext()
//            }) { (error) in
//                //TODO: handle error
//            }
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
        return fetchedResultsController.sections?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch sections[section] {
//        case .advices:
//            return advices.count > 0 ? 1: 0
//        case .consultations:
//            return consultations.count  > 0 ? 1: 0
//        }
        return fetchedResultsController.sections![section].numberOfObjects > 0 ? 1: 0
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
//        switch sections[indexPath.section] {
//        case .advices:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AdviceCollectionCell", for: indexPath) as! AdviceCollectionTableViewCell
//            cell.advices = advices
//            return cell
//        case .consultations:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ConsultationCollectionCell", for: indexPath) as! ConsultationCollectionTableViewCell
//            cell.consultations = consultations
//            return cell
//        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let kind = sections[section]
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderFooterView.identifier) as! HomeHeaderFooterView
        view.lblTitle.text = kind.rawValue.localized()
        view.kind = kind
        view.btnAction.setTitle("seeAll".localized(), for: .normal)
        view.delegate = self
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
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
    
}

//
//  ChildViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 7/26/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "ChildCell"

class ChildsViewController: UICollectionViewController {

    var fetchedResultsController: NSFetchedResultsController<Child>!
    
    func initializeFetchedResultsController() {
        let request: NSFetchRequest<Child> = Child.fetchRequest()
        let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
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
        collectionView?.delegate = self
        
        title = "childs".localized()
        initializeFetchedResultsController()
        
//        UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon"), style: .plain, target: self, action: #selector())
//        let addChildButton = UIBarButtonItem(barButtonSystemItem: <#T##UIBarButtonSystemItem#>, target: <#T##Any?#>, action: <#T##Selector?#>)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChildDetails" {
            let sender = sender as! ChildCollectionViewCell
            
            let vc = segue.destination as! ChildViewController
            vc.child = sender.child
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return fetchedResultsController.sections![section].numberOfObjects
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChildCollectionViewCell
        cell.child = fetchedResultsController.object(at: indexPath)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    var shouldReloadCollectionView = false
}
extension ChildsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 40)/2, height: 160)
    }
}
extension ChildsViewController: NSFetchedResultsControllerDelegate {
    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        
//        if type == NSFetchedResultsChangeType.insert {
//            collectionView!.insertItems(at: [newIndexPath!])
////            if (collectionView?.numberOfSections)! > 0 {
////
////                if collectionView?.numberOfItems( inSection: newIndexPath!.section ) == 0 {
////                    self.shouldReloadCollectionView = true
////                } else {
////                    collectionView!.insertItems(at: [newIndexPath!])
////                }
////
////            } else {
////                self.shouldReloadCollectionView = true
////            }
//        }
//        else if type == NSFetchedResultsChangeType.update {
//            
//            collectionView!.reloadItems(at: [indexPath!])
//        }
//        else if type == NSFetchedResultsChangeType.move {
//            
//            collectionView!.moveItem(at: indexPath!, to: newIndexPath!)
//        }
//        else if type == NSFetchedResultsChangeType.delete {
//            
////            if collectionView?.numberOfItems( inSection: indexPath!.section ) == 1 {
////                self.shouldReloadCollectionView = true
////            } else {
//                collectionView!.deleteItems(at: [indexPath!])
////            }
//        }
//    }
//    
//    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//        if type == NSFetchedResultsChangeType.insert {
//            print("Insert Section: \(sectionIndex)")
//            collectionView!.insertSections(NSIndexSet(index: sectionIndex) as IndexSet)
//        }
//        else if type == NSFetchedResultsChangeType.update {
//            print("Update Section: \(sectionIndex)")
//            collectionView!.reloadSections(NSIndexSet(index: sectionIndex) as IndexSet)
//        }
//        else if type == NSFetchedResultsChangeType.delete {
//            print("Delete Section: \(sectionIndex)")
//            collectionView!.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet)
//        }
//    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.reloadData()
        // Checks if we should reload the collection view to fix a bug @ http://openradar.appspot.com/12954582
//        if (self.shouldReloadCollectionView) {
//            DispatchQueue.main.async {
//                self.collectionView?.reloadData();
//            }
//        } else {
//
//        }
    }
}

//
//  SelectedChildrenAndTotalTableViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 9/14/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class SelectedChildrenAndTotalTableViewController: UITableViewController {
    
    var packageId: Int32!
    var payment: PaymentItem!
    var childIds: [Int32]!
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var lblPaymentMethodTitle: UILabel!
    @IBOutlet weak var lblPaymentMethod: UILabel!
    @IBOutlet weak var imgPaymentMethod: UIImageView!
    
    var totals: [Total] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        lblHeaderTitle.text = "selectedChildren".localized()
        lblPaymentMethodTitle.text = "paymentMethod".localized()
        lblPaymentMethod.text = payment.title
        imgPaymentMethod.image = payment.logo
        
        Lookup.shared.subsecriptionInformation(packageId: packageId, gateway: payment.id, childIds: childIds, success: { [weak self] (attributes) in
            
            if let childrenTotals = attributes["children_rate_table"] as? [[AnyHashable: Any]] {
                for attributes in childrenTotals {
                    if let total = ChildTotal(attributes: attributes) {
                        self?.totals.append(total)
                    }
                }
            }
        
            if let total = attributes["total"] as? Double, let currency = attributes["currency"] as? String {
                var customPrice = CustomPrice()
                customPrice.amount = total
                customPrice.currency = currency
                
                self?.totals.append(ItemTotal(title: "total".localized(), price: customPrice))
            }
            self?.tableView.reloadData()
        }) { (error) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totals.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "selectedChildren".localized()
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TotalCell", for: indexPath) as! TotalTableViewCell
        cell.total = totals[indexPath.row]
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
    }
}

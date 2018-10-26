//
//  ChildViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 8/31/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController {

    var child: Child!
    @IBOutlet weak var childImage: UIImageView!
    @IBOutlet weak var lblChildName: UILabel!
    @IBOutlet weak var lblChildAge: UILabel!
    
    @IBOutlet weak var lblEducationalValues: UILabel!
    @IBOutlet weak var lblConsultations: UILabel!
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var advicesContainerView: UIView!
    @IBOutlet weak var consultationsContainerView: UIView!
    @IBOutlet weak var profileContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "childs".localized()
        
        // style
        lblChildName.textColor = UIColor.tint
        lblChildAge.textColor = UIColor.secondary
        
        lblEducationalValues.textColor = UIColor.white
        lblConsultations.textColor = UIColor.white
        
        segment.layer.borderColor = UIColor.tintOrange.cgColor
        segment.layer.borderWidth = 1
        segment.layer.masksToBounds = true
        
        // data
        childImage.sd_setImage(with: child.imageURL, completed: nil)
        
        lblChildAge.text = child.displayedAge
        lblChildName.text = child.name
        
        lblConsultations.text = child.displayedConsulatationsCount
        lblEducationalValues.text = child.displayedAdvicesCount
        
        segment.setTitle("advices".localized(), forSegmentAt: 0)
        segment.setTitle("consultations".localized(), forSegmentAt: 1)
        segment.setTitle("profile".localized(), forSegmentAt: 2)
        
        segment.selectedSegmentIndex = 0
        segment.sendActions(for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        childImage.layer.cornerRadius = childImage.frame.height / 2
        segment.layer.cornerRadius = segment.bounds.height / 2
    }

    @IBAction func segment_ValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            advicesContainerView.isHidden = false
            consultationsContainerView.isHidden = true
            profileContainerView.isHidden = true
        }else if sender.selectedSegmentIndex == 1 {
            advicesContainerView.isHidden = true
            consultationsContainerView.isHidden = false
            profileContainerView.isHidden = true
        }else {
            advicesContainerView.isHidden = true
            consultationsContainerView.isHidden = true
            profileContainerView.isHidden = false
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedAdvices" {
            let vc = segue.destination as! AdviceTableViewController
            vc.childId = child.id
        }else if segue.identifier == "EmbedChildProfile" {
            let vc = segue.destination as! ChildProfileTableViewController
            vc.child = child
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
extension ChildViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

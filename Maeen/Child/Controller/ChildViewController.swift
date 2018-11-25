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
    
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "childs".localized()
        
        
        rightBarButtonItem.title = "addConsultation".localized()
        
        // style
        lblChildName.textColor = UIColor.tint
        lblChildName.font = UIFont.font(from: .title2)
        
        lblChildAge.textColor = UIColor.secondary
        lblChildAge.font = UIFont.font(from: .subTitle1)
        
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
        lblConsultations.font = UIFont.font(from: .subTitle1)
        
        lblEducationalValues.text = child.displayedAdvicesCount
        lblEducationalValues.font = UIFont.font(from: .subTitle1)
        
        segment.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.font(from: .subTitle1)], for: .normal)
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
        }else if segue.identifier == "AddConsultation" {
            let vc = segue.destination as! ConsultationDetailsViweController
        
            vc.title = consultationTitleTextField?.text
            vc.childId = child.id
            
        }else if segue.identifier == "EmbedConsultations" {
            let vc = segue.destination as! ConsultationTableViewController
            vc.childId = child.id
        }
    }
    

    @IBAction func addConsultationButton_TouchUpInside(_ sender: UIBarButtonItem) {
        self.present(createConsultationAlert, animated: true, completion: nil)
    }
    
    // MARK: - TextFiled + AlertView
    
    
    var consultationTitleTextField: UITextField?
    
    func configurationTextField(textField: UITextField!) {
        if (textField) != nil {
            self.consultationTitleTextField = textField!
            self.consultationTitleTextField?.placeholder = "title".localized();
            self.consultationTitleTextField?.addTarget(self, action: #selector(consultationTitleTextField_EditingChanged(sender:)), for: .editingChanged)
        }
    }
    
    @objc func consultationTitleTextField_EditingChanged(sender: UITextField) {
        okActionForAddConsultation.isEnabled = sender.text?.isEmpty == false
    }
    
    lazy var okActionForAddConsultation: UIAlertAction = {
        let action = UIAlertAction(title: "create".localized(), style: .default, handler:{ (UIAlertAction) in
            self.performSegue(withIdentifier: "AddConsultation", sender: self)
        })
        
        return action
    }()
    
    lazy var createConsultationAlert: UIAlertController! = {
        let alert = UIAlertController(title: "newConsultation".localized(), message: "enter a name for this consultation".localized(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(UIAlertAction(title: "cancel".localized(), style: .cancel, handler:nil))
        
        
        let okAction = okActionForAddConsultation
        okAction.isEnabled = false
        
        alert.addAction(okAction)
        
        return alert
    }()
    
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

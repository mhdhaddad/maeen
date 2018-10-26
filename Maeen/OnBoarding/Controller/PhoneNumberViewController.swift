//
//  PhoneNumberViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 6/9/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class PhoneNumberViewController: UIViewController {
    fileprivate lazy var countryCodes: [String: String] = [:]
    
    lazy var countries: [String: String] = { Utility.countries() }()
    fileprivate var selectedPhoneCode: String? = nil
    
    @IBOutlet weak var btnCountryCode: UIButton!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "What's Your Number".localized()
        setupData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txtPhoneNumber.becomeFirstResponder()
    }
    func setupData() {
        if let path = Bundle.main.path(forResource: "telephoneCodes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let data = jsonResult as? [[AnyHashable: Any]] {
                    countryCodes.reserveCapacity(data.count)
                    
                    for attributes in data {
                        if let phoneCode = PhoneCode(attributes: attributes) {
                            countryCodes[phoneCode.countryCode] = phoneCode.dialCode
                        }
                    }
                    
                }
            } catch {
                // handle error
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CountryCodeSegue" {
            let vc = segue.destination as! CommonTableViewController
            vc.strings = Array(countries.values)
            vc.delegate = self
        }
    }
}
extension PhoneNumberViewController: CommonTableViewControllerDelegate {
    func didSelectItemAt(index: Int, with pageIdentifier: Int, andValue value: String) {
        guard let country = countries.first(where: { (key, _value) -> Bool in
            return _value == value
        }) else {
            return
        }
        
        
        selectedPhoneCode = countryCodes[country.key]
        
        btnCountryCode.setTitle(selectedPhoneCode, for: .normal)
    }
    
    func didAddItem(_ value: String, forIdentifier identifier: Int) {

    }
    
    
}
class PhoneCode {
    var dialCode: String!
    var countryCode: String!
    
    init?(attributes: [AnyHashable: Any]) {
        guard let countryCode = attributes["code"] as? String, let dialCode = attributes["dial_code"] as? String else {
            return nil
        }
        self.countryCode = countryCode
        self.dialCode = dialCode
        
    }
}

//
//  NGORegistrationTableViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/16/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class NGORegistrationTableViewController: UITableViewController {
    @IBOutlet weak var nGONameTextField: UITextField!
    
    @IBOutlet weak var nGOEmailTextField: UITextField!
    
    @IBOutlet weak var nGOAcrimonyTextField: UITextField!
    
    @IBOutlet weak var NGOPhoneNumberTextField: UITextField!
    
    @IBOutlet weak var nGOWebsiteTextField: UITextField!
    
    @IBOutlet weak var nGODescriptionTextView: UITextView!
    
    @IBOutlet weak var nGOCategoriesPickerView: UIPickerView!
    
    @IBOutlet weak var nGOStreetAddressTextField: UITextField!
    
    @IBOutlet weak var nGOCityTextField: UITextField!
    
    @IBOutlet weak var nGOStateTextField: UITextField!
    
    @IBOutlet weak var nGOZipCodeTextField: UITextField!
    
    @IBOutlet weak var nGOContactPersonTextField: UITextField!
    
    @IBOutlet weak var contactPersonPhoneTextField: UITextField!
    
    @IBOutlet weak var contactPersonEmailTextField: UITextField!
    
    
    private func checkNGODetails(){
        guard let ngoName = nGONameTextField.text, let email = nGOEmailTextField.text, let acrimony = nGOAcrimonyTextField.text, let phoneNumber = NGOPhoneNumberTextField.text, let webSite = nGOWebsiteTextField.text, let nGODescription = nGODescriptionTextView.text, let streetAddress = nGOStreetAddressTextField.text, let city = nGOCityTextField.text, let state = nGOStateTextField.text, let postalCode = nGOZipCodeTextField.text, let contactFullName = contactPersonEmailTextField.text, let contactPhoneNumber = contactPersonPhoneTextField.text, let contactEmail = contactPersonEmailTextField.text,
        !ngoName.isEmpty,
        !email.isEmpty,
        !acrimony.isEmpty,
        !phoneNumber.isEmpty,
        !webSite.isEmpty,
        !nGODescription.isEmpty,
        !streetAddress.isEmpty,
        !contactFullName.isEmpty,
        !city.isEmpty,
        !state.isEmpty,
        !postalCode.isEmpty,
        !contactPhoneNumber.isEmpty,
            !contactEmail.isEmpty else {
                showAlert(title: "Missing Fields", message: "Please fill all fields")
                return
             
        }
        
        let registratingNGO = NGO.init(ngoName: ngoName, ngoDescription: nGODescription, ngoWebsite: webSite, ngoCategory: "", ngoAcrimony: acrimony, ngoPhoneNumber: phoneNumber, ngoEmail: email, ngoStreetAddress: streetAddress, ngoCity: city, ngoState: state, ngoZipCode: postalCode, contactPersonName: contactFullName, ngoImagesURL: "", ratingsValue: 0.0, reviews: "", mondayHours: "", tuesdayHours: "", wedsDayHours: "", thursdayHours: "", fridayHours: "", saturdayHours: "", sundayHours: "", visitedDate: "", ngOID: "")
        DataBaseService.createNGO(with: registratingNGO) { (error) in
            if error != nil {
                
            } else {
                self.showAlert(title: "Success", message: "Thank you for helping us grow our support community")
            }
        }
        
        
        
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "033860")
    }
    
    
    @IBAction func RegisterButtonPressed(_ sender: UIButton) {
    }
    
    

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
}

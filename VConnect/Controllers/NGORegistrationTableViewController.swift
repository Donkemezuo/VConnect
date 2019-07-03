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
    
    @IBOutlet weak var mondayHoursTextField: UITextField!
    
    @IBOutlet weak var tuesDayHoursTextField: UITextField!
    
    @IBOutlet weak var wednesDayTextField: UITextField!
    @IBOutlet weak var thursDayTextField: UITextField!
    @IBOutlet weak var fridayTextField: UITextField!
    @IBOutlet weak var sundayHoursTextField: UITextField!
    @IBOutlet weak var satursDayTextField: UITextField!
    
    private var nGOCategories = ["Domestic Violence", "Child issues", "Sexual Assault", "Human Rights", "Women", "Youth Development", "Education", "Homelessness", "Leadership", "Economic Development"]
    
    private var nGOCategory = ""
    
    
    private func checkNGODetails(){
        guard let ngoName = nGONameTextField.text,
            let email = nGOEmailTextField.text,
            let acrimony = nGOAcrimonyTextField.text,
            let phoneNumber = NGOPhoneNumberTextField.text,
            let webSite = nGOWebsiteTextField.text,
            let nGODescription = nGODescriptionTextView.text,
            let streetAddress = nGOStreetAddressTextField.text,
            let city = nGOCityTextField.text,
            let state = nGOStateTextField.text,
            let postalCode = nGOZipCodeTextField.text,
            let contactFullName = contactPersonEmailTextField.text,
            let contactPhoneNumber = contactPersonPhoneTextField.text,
            let contactEmail = contactPersonEmailTextField.text,
            let mondayHours = mondayHoursTextField.text,
            let tuesdayHours = tuesDayHoursTextField.text,
            let wednesdayHours = wednesDayTextField.text,
            let thursdayHours = thursDayTextField.text,
            let fridayHours = fridayTextField.text,
            let satursdayHours = satursDayTextField.text,
            let sundayHours = sundayHoursTextField.text,
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
            !contactEmail.isEmpty,
        !mondayHours.isEmpty,
        !tuesdayHours.isEmpty,
        !wednesdayHours.isEmpty,
        !thursdayHours.isEmpty,
        !fridayHours.isEmpty,
        !satursdayHours.isEmpty,
        !sundayHours.isEmpty
        else {
                showAlert(title: "Missing Fields", message: "Please fill all fields")
                return
             
        }
        
        let registratingNGO = NGO.init(ngoName: ngoName, ngoDescription: nGODescription, ngoWebsite: webSite, ngoCategory: "", ngoAcrimony: acrimony, ngoPhoneNumber: phoneNumber, ngoEmail: email, ngoStreetAddress: streetAddress, ngoCity: city, ngoState: state, ngoZipCode: postalCode, contactPersonName: contactFullName, ngoImagesURL: "", ratingsValue: 0.0, reviews: "", mondayHours: mondayHours, tuesdayHours: tuesdayHours, wedsDayHours: wednesdayHours, thursdayHours: thursdayHours, fridayHours: fridayHours, saturdayHours: satursdayHours, sundayHours: sundayHours, visitedDate: "", ngOID: "")
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
        nGOCategoriesPickerView.delegate = self
        nGOCategoriesPickerView.dataSource = self
    }
    
    
    @IBAction func RegisterButtonPressed(_ sender: UIButton) {
        checkNGODetails()
    }
    
    @IBAction func cancelRegistration(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
}

extension NGORegistrationTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return nGOCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nGOCategory = nGOCategories[row]
        

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return nGOCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let category = nGOCategories[row]


        return NSAttributedString(string: category, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 400
    }
    
    
    
    
//
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        var label: UILabel
//        if let v = view as? UILabel {
//            label = v
//        } else {
//            label = UILabel()
//        }
//
//        label.layer.cornerRadius = 30
//        label.layer.borderWidth = 2
//        label.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
//        label.textColor = .white
//        label.textAlignment = .center
//        label.font = UIFont(name: "Helvetica-Bold", size: 20)
//        label.text = nGOCategories[row]
//
//        return label
//    }
    
   
    
    
}

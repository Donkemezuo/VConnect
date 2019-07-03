//
//  SpecialistRegistrationTableViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/3/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class SpecialistRegistrationTableViewController: UITableViewController {
    
    private var areaOfSpeciality = ""
    private var specialistProfession = ""
    private var categories = ["Children and Women", "Youth Empowerment","Rape","Housing and Homelessness","Legal Aid", "Widow"]
    private var professions = ["Human Lawyer","Activist","Social Worker"]
    
    var vConnecter:VConnectUser!
    
    private var tapGesture: UITapGestureRecognizer!
    
    
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var specialistProfileImageView: UIImageView!
    
    @IBOutlet weak var firstNameTxtField: UITextField!
    
    @IBOutlet weak var lastNameTxtField: UITextField!
    
    @IBOutlet weak var aboutTxtView: UITextView!
    @IBOutlet weak var cityTxtField: UITextField!
    
    @IBOutlet weak var stateTxtField: UITextField!
    
    @IBOutlet weak var postalCodeTxtField: UITextField!
    
    @IBOutlet weak var areaOfSpecialtyPickerView: UIPickerView!
    
    @IBOutlet weak var yearsOfExperienceTxtField: UITextField!
    
    @IBOutlet weak var currentCompanyTxtField: UITextField!
    
    
    @IBOutlet weak var WhoYouArePickerView: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        areaOfSpecialtyPickerView.delegate = self
        areaOfSpecialtyPickerView.dataSource = self
        WhoYouArePickerView.delegate = self
        WhoYouArePickerView.dataSource = self
        view.backgroundColor = UIColor.init(hexString: "033860")
        defaultSettings()
        
    }
    
    
    private func defaultSettings(){
        
        firstNameTxtField.text = vConnecter.firstName
        lastNameTxtField.text = vConnecter.lastName
        
        if let photoURL = vConnecter.profileImageURL {
            specialistProfileImageView.kf.setImage(with: URL(string: photoURL), placeholder:#imageLiteral(resourceName: "icons8-user.png") )
        }
        
        
    }
    
    
    
    
    
    private func checkSpecialistInfo(){
        guard let firstName = firstNameTxtField.text,
            let lastName = lastNameTxtField.text,
            let about = aboutTxtView.text,
            let state = stateTxtField.text,
            let city = cityTxtField.text,
            let postalCode = postalCodeTxtField.text,
            let yearsOfExperience = yearsOfExperienceTxtField.text,
            let currentCompany = currentCompanyTxtField.text,
            !firstName.isEmpty,
            !lastName.isEmpty,
            !state.isEmpty,
            !city.isEmpty,
            !postalCode.isEmpty,
            !yearsOfExperience.isEmpty,
            !about.isEmpty,
            !currentCompany.isEmpty else {
                self.showAlert(title: "Missing Fields", message: "All fields require filling")
                return
        }
        
        let registerSpecialist = VConnectSpecialist.init(firstName: firstName, lastName: lastName, biography: about, location: "", areaOfSpecialty: areaOfSpeciality, yearsOfExperience: Int(yearsOfExperience) ?? 1, ratingsValue: 3.0, specialistID: vConnecter.userID, specialistProfileImageURL: vConnecter.profileImageURL ?? "", joinedDate: Date.getISOTimestamp(), coverImageURL: "", profession: specialistProfession)
        
        DataBaseService.createSpecialist(with: registerSpecialist) { (error) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error \(error.localizedDescription) switching to a specialist account")
            } else {
                self.showAlert(title: "Success", message: "Successfully switched to Specialist")
                
            }
        }
        
        
    }


    @IBAction func canCelRegistration(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func becomeASpecialist(_ sender: UIButton) {
        checkSpecialistInfo()
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    
}


extension SpecialistRegistrationTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return professions.count
        case 2:
            return categories.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return professions[row]
        case 2:
            return categories[row]
            
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            specialistProfession = professions[row]
        case 2:
            areaOfSpeciality = categories[row]
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var displayText = ""
        switch pickerView.tag {
            
        case 1:
            displayText = professions[row]
        case 2:
            displayText = categories[row]
        default:
            displayText = ""
            
        }
        
        return NSAttributedString(string: displayText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 340
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
                var label: UILabel
                if let v = view as? UILabel {
                    label = v
                } else {
                    label = UILabel()
                }
        
                label.layer.cornerRadius = 25
                label.layer.borderWidth = 3
                label.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                label.textColor = .white
                label.textAlignment = .center
                label.font = UIFont(name: "Helvetica-Bold", size: 18)
        
        switch pickerView.tag {
        case 1:
            label.text = professions[row]
        case 2:
            label.text = categories[row]
        default:
            label.text = ""
        }
        
    
    return label
    }
    
    
    
}

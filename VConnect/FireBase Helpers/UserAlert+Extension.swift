//
//  UserAlert+Extension.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/24/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    public func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    public func showAlert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    public func confirmDeletionActionSheet(handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: "Are you sure?", message: "This action will log you out of VConnect", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Log out", style: .destructive, handler: handler)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        if let popOverPresentationController = alertController.popoverPresentationController {
            popOverPresentationController.sourceView = self.view
            popOverPresentationController.sourceRect = CGRect(x: 1.0, y: 1.0, width: self.view.bounds.width, height: self.view.bounds.height)
        }
          self.present(alertController, animated: true)
    }
    
    public func segueToSignInVC(title: String, message: String, handler: ((UIAlertAction) -> Void)? ) {
             let alertController = UIAlertController(title: "Error", message: "Please sign In or create a VConnect account. Only registered users can bookmark", preferredStyle: .actionSheet)
            
            let signIn = UIAlertAction(title: "Sign In", style: .default, handler: handler)

        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(signIn)
        alertController.addAction(cancel)
        if let popOverPresentationController = alertController.popoverPresentationController {
            popOverPresentationController.sourceView = self.view
            popOverPresentationController.sourceRect = CGRect(x: 1.0, y: 1.0, width: self.view.bounds.width, height: self.view.bounds.height)
        }
         self.present(alertController, animated: true)
    }
    
    public func confirmFirstNameChange(handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: "Change first name?", message: "You can change your first name", preferredStyle: .actionSheet)
        let changeFirstName = UIAlertAction(title: "Change first name", style: .cancel)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: handler)
        alertController.addAction(cancel)
        alertController.addAction(changeFirstName)
        self.present(alertController, animated: true)
    }
    
    public func showActionSheet(title: String?, message: String?, actionTitles: [String], handlers: [((UIAlertAction) -> Void)]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for (index, actionTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(title: actionTitle, style: .default, handler: handlers[index])
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
}
}

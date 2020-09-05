//
//  RegistartionViewController.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 01.09.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit
import Firebase

class RegistartionViewController: TextFieldsViewController {
    
    // MARK: - Private properties
    private let authManager = AuthManager.shared
    
    @IBAction func signUpDidTouch(_ sender: AnyObject) {
        guard
            let emailTextField = textFields.first(where: { $0.tag == 0 }),
            let passwordTextField = textFields.first(where: { $0.tag == 1 }),
            Validator.isPassValid(testStr: passwordTextField.text ?? "N/A"),
            Validator.isEmailValid(testStr: emailTextField.text ?? "N/A"),
            let email = emailTextField.text,
            let pass = passwordTextField.text else {
                showErrorAlert(message: "Неверный формат или длина")
                return
        }
        activityIndicator.show()
        authManager.signUp(email: email, password: pass) { error in
            if let error = error {
                self.activityIndicator.hide()
                self.showErrorAlert(message: error.localizedDescription)
            } else {
                self.activityIndicator.hide()
                self.performSegue(withIdentifier: "showVerificationScreen", sender: self)
            }
        }
    }
}

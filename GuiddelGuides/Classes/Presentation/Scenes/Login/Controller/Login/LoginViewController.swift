//
//  LoginViewController.swift
//  Guiddel
//
//  Created by Anton Danilov on 27.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: TextFieldsViewController {
        
    // MARK: - Private properties
    private let authManager = AuthManager.shared
    
    // MARK: IBActions
    @IBAction func loginDidTouch(_ sender: AnyObject) {
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
        authManager.signIn(email: email, password: pass) { error in
            if let error = error {
                self.activityIndicator.hide()
                self.showErrorAlert(message: error.localizedDescription)
            }
            self.activityIndicator.hide()
        }
    }
}

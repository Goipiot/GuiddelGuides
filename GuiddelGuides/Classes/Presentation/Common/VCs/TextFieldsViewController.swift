//
//  TextFieldsViewController.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 01.09.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class TextFieldsViewController: UIViewController {
    @IBOutlet var textFields: [UITextField]!
    
    // MARK: UIViewController
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHUD()
    }
    // MARK: Properties
    var activityIndicator: ActivityIndicator!
    
    // MARK: Public Methods
    func setupHUD() {
        activityIndicator = ActivityIndicator(text: "Загрузка")
        activityIndicator.hide()
        self.view.addSubview(activityIndicator)
    }
}



// MARK: - Errors handling
extension TextFieldsViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension TextFieldsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        
        if tag == textFields.count - 1 {
            for field in textFields {
                field.resignFirstResponder()
            }
        } else {
            if let field = textFields.first(where: { $0.tag == tag + 1 }) {
                field.becomeFirstResponder()
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 160)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 160)
    }
    
    func animateViewMoving(up: Bool, moveValue: CGFloat) {
        let movementDuration: TimeInterval = 0.3
        let movement: CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}

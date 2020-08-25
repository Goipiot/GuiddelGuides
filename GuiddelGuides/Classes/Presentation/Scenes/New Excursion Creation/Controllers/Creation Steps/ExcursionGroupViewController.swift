//
//  ExcursionGroupViewController.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 14.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class ExcursionGroupViewController: UIViewController {
    
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        checkButtonStatus()
    }
    @IBAction func nextButtonClicked(_ sender: UIBarButtonItem) {
        guard let text = textField.text,
            let value = Int(text) else { return }
        ExcursionBuilder.shared.setGroupSize(size: value)
        performSegue(withIdentifier: "showDateScreen", sender: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func userChangedText(_ sender: UITextField) {
        checkButtonStatus()
    }
    
}

// MARK: - UITextFieldDelegate
extension ExcursionGroupViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if CreationValidator.isValidName(testStr: textField.text ?? "login") || textField.text == "" {
            errorLabel.text = " "
        } else {
            errorLabel.text = "Неверный формат"
        }
        underlineView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        checkButtonStatus()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        underlineView.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.2352941185, blue: 1, alpha: 1)
        checkButtonStatus()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func checkButtonStatus() {
        if CreationValidator.isValidName(testStr: textField.text ?? "") && textField.text != "" {
            nextButton.isEnabled = true
            nextButton.tintColor = #colorLiteral(red: 0.1215686277, green: 0.2352941185, blue: 1, alpha: 1).withAlphaComponent(1)
        } else {
            nextButton.isEnabled = false
            nextButton.tintColor = #colorLiteral(red: 0.1215686277, green: 0.2352941185, blue: 1, alpha: 1).withAlphaComponent(0.2)
        }
    }
    
}

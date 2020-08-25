//
//  ExcursionCreationViewController.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 14.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class ExcursionCreationViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar
            .largeTitleTextAttributes = [NSAttributedStringKey.font: UIFont.getOswald(.bold, size: 34)]
        checkButtonStatus()

        // Do any additional setup after loading the view.
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        guard let text = textField.text else { return }
        ExcursionBuilder.shared.setTitle(title: text)
        performSegue(withIdentifier: "showPriceScreen", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func userChangedText(_ sender: UITextField) {
        checkButtonStatus()
    }
}

// MARK: - UITextFieldDelegate
extension ExcursionCreationViewController: UITextFieldDelegate {
    
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

//
//  VerificationViewController.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 01.09.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class VerificationViewController: ExcursionCreationViewController {
    
    // MARK: - Private Properties
    private let museumDB = MuseumFirestoreManager.shared

    // MARK: - IBActions
    override func nextButtonPressed(_ sender: Any) {
        guard let text = textField.text else { return }
        
        museumDB.verifyGuide(museumCode: text) { err in
            if err != nil {
                self.showErrorAlert(message: "Код введен неверно или не существует")
            } else {
                print("Начал")
                guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
                print("Закончил")
                appDel.openCreationScene(open: false)
            }
        }
    }

}

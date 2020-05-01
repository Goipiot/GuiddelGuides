//
//  UserProfileViewController.swift
//  Guiddel
//
//  Created by Anton Danilov on 26.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

class UserProfileViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var changeProfileButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView! 
    
    // MARK: Properties
    var activityIndicator: ActivityIndicator!

    // MARK: UIViewController Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        DatabaseManager.shared.getUserUpdates { user, error  in
            if let error = error, user == nil {
                self.showErrorAlert(message: error.localizedDescription)
            } else if let user = user {
                self.updateUserData(with: user)
            }
        }
    }
    
    @IBAction func updateButtonPressed(_ sender: Any) {
        guard let image = profileImage.image,
            let displayName = nameTextField.text else {
                self.showErrorAlert(message: "nil image or text")
                return
        }
        if Validator.isNameValid(testStr: displayName) {
            activityIndicator.show()
            AccountManager.shared.updateUserInfo(displayName: displayName, image: image) { error in
                if let error = error {
                    self.activityIndicator.hide()
                    self.showErrorAlert(message: error.localizedDescription)
                    self.updateButton.isHidden = false
                } else {
                    self.activityIndicator.hide()
                    self.updateButton.isHidden = true
                }
            }
        } else {
            self.showErrorAlert(message: "name is too short")
        }
    }
    
    @IBAction func deleteUserButtonPressed(_ sender: Any) {
        AuthManager.shared.deleteAccount { error in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func logoutUserButtonPressed(_ sender: Any) {
        AuthManager.shared.logOut { error in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } 
        }
    }
    
}

// MARK: UIImagePickerControllerDelegate
extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func selectImageTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // will run if the user hits cancel
        picker.dismiss(animated: true, completion: nil)
    }

    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // will run when the user finishes picking an image from the library
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profileImage.image = pickedImage
            self.updateButton.isHidden = false
            picker.dismiss(animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Error Handling
extension UserProfileViewController {
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

// MARK: UITextFieldDelegate
extension UserProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButton.isHidden = false
    }
    
}

// MARK: Update User Info
extension UserProfileViewController {
    func updateUserData(with user: User) {
        updateImage(from: user.photoURL) { error in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
        if let displayName = user.displayName {
            self.nameTextField.text = displayName
        }
    }
    
    func updateImage(from photoURLString: String?, completion: @escaping (Error?) -> Void) {
        guard let string = photoURLString else {return}
        let createdUrl = URL(string: string)
        guard let url = createdUrl else {return}
        DispatchQueue.main.async {
            self.getData(from: url) { data, response, error in
                guard let data = data, error == nil else {
                    completion(error)

                    return
                }
                DispatchQueue.main.async() {
                    self.profileImage.image = UIImage(data: data)
                }
                completion(nil)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

// MARK:- Setup UI
extension UserProfileViewController {
    func setup() {
        activityIndicator = ActivityIndicator(text: "Updating...")
        activityIndicator.hide()
        self.view.addSubview(activityIndicator)
    }
}


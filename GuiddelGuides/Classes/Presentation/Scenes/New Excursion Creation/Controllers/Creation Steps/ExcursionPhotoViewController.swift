//
//  ExcursionPhotoViewController.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 15.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class ExcursionPhotoViewController: UIViewController {

    @IBOutlet weak var excursionImage: RoundCornersImage!
    @IBOutlet weak var createBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        excursionImage.image = #imageLiteral(resourceName: "british-museum-london-exterior")
        checkButtonStatus()
    }
    
    @IBAction func userPressedPhotoButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func createButtonPresesed(_ sender: Any) {
        guard let image = excursionImage.image else { return }
        ExcursionBuilder.shared.setImage(image: image)
        performSegue(withIdentifier: "showPreviewScreen", sender: self)
    }
    
    private func checkButtonStatus() {
        if excursionImage.image == #imageLiteral(resourceName: "british-museum-london-exterior") {
            createBarButton.isEnabled = false
            createBarButton.tintColor = #colorLiteral(red: 0.1215686277, green: 0.2352941185, blue: 1, alpha: 1).withAlphaComponent(0.2)
        } else {
            createBarButton.isEnabled = true
            createBarButton.tintColor = #colorLiteral(red: 0.1215686277, green: 0.2352941185, blue: 1, alpha: 1).withAlphaComponent(1)
        }
    }

}

// MARK: UIImagePickerControllerDelegate
extension ExcursionPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // will run if the user hits cancel
        picker.dismiss(animated: true, completion: nil)
    }

    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        // will run when the user finishes picking an image from the library
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.excursionImage.image = pickedImage
            picker.dismiss(animated: true, completion: nil)
        }
        checkButtonStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

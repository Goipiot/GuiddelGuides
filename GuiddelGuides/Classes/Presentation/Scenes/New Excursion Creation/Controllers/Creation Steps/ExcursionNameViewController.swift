//
//  ExcursionNameViewController.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 15.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class ExcursionNameViewController: ExcursionCreationViewController {
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
        appDel.openCreationScene(open: false)
    }
}

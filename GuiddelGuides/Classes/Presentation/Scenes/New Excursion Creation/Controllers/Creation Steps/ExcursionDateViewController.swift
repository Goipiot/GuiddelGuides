//
//  ExcursionDateViewController.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 15.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class ExcursionDateViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func datePickerValueChanged(_ sender: Any) {
        let date = DateFormatter.get(with: .fullWithTime).string(from: datePicker.date)
        let day = DateFormatter.get(with: .full).string(from: datePicker.date)
        ExcursionBuilder.shared.setDate(time: date, day: day)
    }
}

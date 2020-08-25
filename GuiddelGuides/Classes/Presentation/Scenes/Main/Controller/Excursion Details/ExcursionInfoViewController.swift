//
//  ExcursionInfoViewController.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 22.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class ExcursionInfoViewController: UIViewController {
    
    @IBOutlet weak var excursionTableView: UITableView!
    @IBOutlet weak var excursionImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        excursionTableView.register(UINib(nibName: "ExcursionMuseumNameTableViewCell", bundle: nil),
                                    forCellReuseIdentifier: ExcursionMuseumNameTableViewCell.identifier)
        excursionTableView.register(UINib(nibName: "ExcursionNameTableViewCell", bundle: nil),
                                    forCellReuseIdentifier: ExcursionNameTableViewCell.identifier)
        excursionTableView.register(UINib(nibName: "ExcursionSizeTableViewCell", bundle: nil),
                                    forCellReuseIdentifier: ExcursionSizeTableViewCell.identifier)
        excursionTableView.register(UINib(nibName: "ExcursionDateTableViewCell", bundle: nil),
                                    forCellReuseIdentifier: ExcursionDateTableViewCell.identifier)
        excursionTableView.register(UINib(nibName: "ExcursionPriceTableViewCell", bundle: nil),
                                    forCellReuseIdentifier: ExcursionPriceTableViewCell.identifier)
        excursionTableView.register(UINib(nibName: "ExcursionParticipantsTableViewCell", bundle: nil),
                                    forCellReuseIdentifier: ExcursionParticipantsTableViewCell.identifier)
    }
    
}

// MARK: - Error Handling
extension ExcursionInfoViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

extension ExcursionInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

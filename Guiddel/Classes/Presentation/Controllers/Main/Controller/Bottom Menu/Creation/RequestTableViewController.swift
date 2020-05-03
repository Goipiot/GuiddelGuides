//
//  RequestTableViewController.swift
//  Guiddel
//
//  Created by Anton Danilov on 02.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class RequestTableViewController: UITableViewController {

    @IBOutlet weak var nameCell: UITableViewCell!
    @IBOutlet weak var timeCell: UITableViewCell!
    @IBOutlet weak var calendarCell: UITableViewCell!
    
    private var menuisOpened: Bool = true {
        didSet {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: - Table view data source
extension RequestTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {

            if let museumName = MuseumRequestManager.shared.museum?.name {
                nameCell.selectionStyle = .none
                nameCell.textLabel?.text = museumName
            }
            return nameCell
        } else if indexPath.row == 1 {
            timeCell.selectionStyle = .none
            return timeCell
        } else {
            calendarCell.selectionStyle = .none
            return calendarCell
        }
    }
}
// MARK: - Table view delegate
extension RequestTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            menuisOpened = !menuisOpened
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !menuisOpened, indexPath.row == 2 {
            return 0
        } else if menuisOpened, indexPath.row == 2 {
            return 220
        }
        return tableView.rowHeight
    }
}

//
//  SearchTableViewController.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    // MARK:- Private properties
    private var userArray: [User] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - UITableViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SearchCell.self, forCellReuseIdentifier: "userCell")
        tableView.contentInset = UIEdgeInsets.zero
        loadData()
    }
}

// MARK: - Table view data source
extension SearchTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! SearchCell
        let cell = UITableViewCell(style: .default, reuseIdentifier: "userCell1")
        if userArray.count > 0 {
            //            cell.titleLabel.text = userArray[indexPath.row].displayName
            //            cell.subTitleLabel.text = userArray[indexPath.row].email
            cell.textLabel?.text = userArray[indexPath.row].displayName
            cell.detailTextLabel?.text = userArray[indexPath.row].email
            return cell
        } else {
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.1
    }
    
    
}

// MARK:- Get data from Firebase
extension SearchTableViewController {
    func loadData() {
        DatabaseManager.shared.getAllUsers { err, users in
            if let err = err {
                self.showErrorAlert(message: err.localizedDescription)
            } else {
                guard let users = users else {return}
                self.userArray = users
            }
        }
    }
}

// MARK: - Error Handling
extension SearchTableViewController {
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}


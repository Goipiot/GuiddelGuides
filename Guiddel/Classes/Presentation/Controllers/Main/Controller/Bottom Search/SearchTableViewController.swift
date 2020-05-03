//
//  SearchTableViewController.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

protocol SearchTableViewControllerDelegate: class {
    func museumPicked(museum: MuseumViewModel)
}

class SearchTableViewController: UITableViewController {
    
    // MARK:- Private properties
    private let museumService = ServiceLayer.shared.museumService
    private var museumArray: [MuseumViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Public Properties
    weak var delegate: SearchTableViewControllerDelegate?
    
    //MARK: - UITableViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SearchCell.self, forCellReuseIdentifier: "userCell")
        tableView.contentInset = UIEdgeInsets.zero
        tableView.separatorStyle = .none
        getMuseums()
    }
}

// MARK: - Table view data source
extension SearchTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return museumArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! SearchCell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "userCell1")
        cell.selectionStyle = .none
        if museumArray.count > 0 {
            //            cell.titleLabel.text = userArray[indexPath.row].displayName
            //            cell.subTitleLabel.text = userArray[indexPath.row].email
            cell.textLabel?.text = museumArray[indexPath.row].name
            cell.detailTextLabel?.text = museumArray[indexPath.row].distanceString
            return cell
        } else {
            return cell
        }
    }
    
    
}

// MARK: - Table view Delegate
extension SearchTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
//        MuseumRequestManager.shared.museum = museumArray[indexPath.row].name
        delegate?.museumPicked(museum: museumArray[indexPath.row])
        print(museumArray[indexPath.row].name)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
// MARK:- Get data from Минкульт
extension SearchTableViewController {
    func getMuseums() {
        museumService.getMuseums() { museums, error in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else {
                var museumViewModelArray: [MuseumViewModel] = []
                guard let museums = museums else {return}
                for museum in museums.data {
                    do {
                        let museumVM = try MuseumViewModel(museum.data.general)!
                        museumViewModelArray.append(museumVM)
                    } catch let error {
                        self.showErrorAlert(message: error.localizedDescription)
                    }
                }
                museumViewModelArray.sort {
                    $0.distance < $1.distance
                }
                self.museumArray = museumViewModelArray
            }
        }
    }
}


// MARK:- Get data from Firebase
//extension SearchTableViewController {
//    func loadData() {
//        DatabaseManager.shared.getAllUsers { err, users in
//            if let err = err {
//                self.showErrorAlert(message: err.localizedDescription)
//            } else {
//                guard let users = users else {return}
//                self.userArray = users
//            }
//        }
//    }
//}

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


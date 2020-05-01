//
//  BottomTableViewController.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class BottomTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideHeader()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let cell = cell as? SearchCell {
            switch indexPath.row {
            case 0:
                cell.iconImageView.image = UIImage(named: "mark")
                cell.titleLabel.text = "Marked Location"
                cell.subTitleLabel.text = "Golden Gate Bridge, San Francisco"
            default:
                cell.iconImageView.image = UIImage(named: "like")
                cell.titleLabel.text = "Favorites"
                cell.subTitleLabel.text = "0 Places"
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func showHeader() {
        changeHeader(height: 116.0)
    }
    
    func hideHeader() {
        changeHeader(height: 0.0)
    }
    
    func changeHeader(height: CGFloat) {
        tableView.beginUpdates()
        if let headerView = tableView.tableHeaderView  {
            UIView.animate(withDuration: 0.25) {
                var frame = headerView.frame
                frame.size.height = height
                self.tableView.tableHeaderView?.frame = frame
            }
        }
        tableView.endUpdates()
    }
    
}

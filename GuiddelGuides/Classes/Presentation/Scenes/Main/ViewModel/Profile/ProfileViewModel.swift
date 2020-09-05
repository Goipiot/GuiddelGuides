//
//  ProfileViewModel.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 01.09.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewModel: NSObject {
    
    var items = [ProfileViewModelItem]()
    var guide: User!
    
    init(guide: User) {
        super.init()
        
        self.guide = guide

    }
}

// MARK: UITableViewDataSource
extension ProfileViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        

        // return the default cell if none of above succeed
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//    }
    
    //    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    //        let rightSection = items.firstIndex(where: { $0 as? ExcursionViewModelTicketsItem != nil })
    //        if section == rightSection {
    //            return " "
    //        } else {
    //            return ""
    //        }
    //    }
}

//
//  ExcursionViewModel.swift
//  Guiddel
//
//  Created by Anton Danilov on 13.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//
import Foundation
import UIKit

class ExcursionViewModel: NSObject {
    
    var items = [ExcursionViewModelItem]()
    var excursion: Excursion!
    
    init(excursion: Excursion) {
        super.init()
        
        self.excursion = excursion
        let museumNameItem = ExcursionViewModelMuseumNameItem(museumName: excursion.museum.name)
        items.append(museumNameItem)
        
        let excursionNameItem = ExcursionViewModelExcursionNameItem(excursionName: excursion.title)
        items.append(excursionNameItem)
        
        //        if let name = excursion.guide.displayName,
        //            let photoURL = excursion.guide.photoURL {
        //            let excursionGuideItem = ExcursionViewModelGuideItem(pictureUrl: photoURL,
        //                                                                 userName: name)
        //            items.append(excursionGuideItem)
        //        }
        
        let excursionDateItem = ExcursionViewModelDateItem(date: excursion.date)
        items.append(excursionDateItem)
        
        let excursionPriceItem = ExcursionViewModelPriceItem(price: Double(excursion.price))
        items.append(excursionPriceItem)
        
        let excursionSizeItem = ExcursionViewModelSizeItem(size: excursion.groupLimit)
        items.append(excursionSizeItem)
        
        let participants = Array(excursion.participants.values)
        if participants.count != 0 {
            let participantsItem = ExcursionViewModelParticipantsItem(participants: participants)
            items.append(participantsItem)
        }
    }
}

// MARK: UITableViewDataSource
extension ExcursionViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .museumName:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: ExcursionMuseumNameTableViewCell.identifier,
                for: indexPath) as? ExcursionMuseumNameTableViewCell {
                cell.item = item
                return cell
            }
            
        case .excursionName:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: ExcursionNameTableViewCell.identifier,
                for: indexPath) as? ExcursionNameTableViewCell {
                cell.item = item
                return cell
            }
        case .guide:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: ExcursionGuideTableViewCell.identifier,
                for: indexPath) as? ExcursionGuideTableViewCell {
                cell.item = item
                return cell
            }
        case .time:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: ExcursionDateTableViewCell.identifier,
                for: indexPath) as? ExcursionDateTableViewCell {
                cell.item = item
                return cell
            }
        case .price:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: ExcursionPriceTableViewCell.identifier,
                for: indexPath) as? ExcursionPriceTableViewCell {
                cell.item = item
                return cell
            }
        case .size:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: ExcursionSizeTableViewCell.identifier,
                for: indexPath) as? ExcursionSizeTableViewCell {
                cell.item = item
                return cell
            }
        case .participants:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: ExcursionParticipantsTableViewCell.identifier,
                for: indexPath) as? ExcursionParticipantsTableViewCell {
                if let participantsItem = item as? ExcursionViewModelParticipantsItem {
                    print("", participantsItem.participants[indexPath.row])
                    cell.item = participantsItem.participants[indexPath.row]
                }
                return cell
            }
            
        }
        // return the default cell if none of above succeed
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == items.count - 1 {
            return ""
        }
        return nil
    }
}

protocol ExcursionViewModelItem {
    var type: ExcursionViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}

extension ExcursionViewModelItem {
    var rowCount: Int {
        return 1
    }
}

enum ExcursionViewModelItemType {
    case museumName
    case excursionName
    case guide
    case time
    case price
    case participants
    case size
}

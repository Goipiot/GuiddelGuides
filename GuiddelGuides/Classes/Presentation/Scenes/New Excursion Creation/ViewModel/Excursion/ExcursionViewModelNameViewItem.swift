//
//  ExcursionViewModelNameViewItem.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 16.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

class ExcursionViewModelMuseumNameItem: ExcursionViewModelItem {
    var type: ExcursionViewModelItemType {
        return .museumName
    }
    var sectionTitle: String {
        return "Музей"
    }
    var museumName: String
    
    init(museumName: String) {
        self.museumName = museumName
    }
}

class ExcursionViewModelExcursionNameItem: ExcursionViewModelItem {
    var type: ExcursionViewModelItemType {
        return .excursionName
    }
    var sectionTitle: String {
        return "Экскурсия"
    }
    var excursionName: String
    
    init(excursionName: String) {
        self.excursionName = excursionName
    }
}

class ExcursionViewModelGuideItem: ExcursionViewModelItem {
    var type: ExcursionViewModelItemType {
        return .guide
    }
    var sectionTitle: String {
        return "Гид"
    }
    
    var pictureUrl: String
    var guideName: String
    
    init(pictureUrl: String, userName: String) {
        self.pictureUrl = pictureUrl
        self.guideName = userName
    }
}

class ExcursionViewModelDateItem: ExcursionViewModelItem {
    var type: ExcursionViewModelItemType {
        return .time
    }
    var sectionTitle: String {
        return "Дата и время"
    }
    
    var date: String
    
    init(date: String) {
        self.date = date
    }
}

class ExcursionViewModelPriceItem: ExcursionViewModelItem {
    var type: ExcursionViewModelItemType {
        return .price
    }
    var sectionTitle: String {
        return "Стоимость"
    }
    
    var price: Double
    
    init(price: Double) {
        self.price = price
    }
}

class ExcursionViewModelTimeItem: ExcursionViewModelItem {
    var type: ExcursionViewModelItemType {
        return .time
    }
    var sectionTitle: String {
        return "Время"
    }
    
    var time: String
    
    init(time: String) {
        self.time = time
    }
}
class ExcursionViewModelSizeItem: ExcursionViewModelItem {
    var type: ExcursionViewModelItemType {
        return .size
    }
    
    var sectionTitle: String {
        return "Размер группы"
    }
    
    var size: Int
    
    init(size: Int) {
        self.size = size
    }
}

class ExcursionViewModelParticipantsItem: ExcursionViewModelItem {
    var type: ExcursionViewModelItemType {
        return .participants
    }
    
    var sectionTitle: String {
        return "Участники"
    }
    
    var rowCount: Int {
        return participants.count
    }
    
    var participants: [User]
    
    init(participants: [User]) {
        self.participants = participants
    }
}

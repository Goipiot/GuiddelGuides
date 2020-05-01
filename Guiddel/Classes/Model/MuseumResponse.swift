//
//  MuseumResponse.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

// MARK: - Main
struct Main: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let general: General
}

// MARK: - General
struct General: Codable {
    let workingSchedule: [String: WorkingSchedule]
    let organization: Organization
    let image: Image
    let gallery: [Image]
    let contacts: Contacts
    let category: Category
    let address: GeneralAddress
    let status, generalDescription, name: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case workingSchedule, organization, image, gallery
        case contacts, category, address, status
        case generalDescription = "description"
        case name, id
    }
}

// MARK: - GeneralAddress
struct GeneralAddress: Codable {
    let mapPosition: MapPosition
    let fullAddress: String
    let comment, street: String
    
}

// MARK: - MapPosition
struct MapPosition: Codable {
    let coordinates: [Double]
    let type: String?
    
}

// MARK: - Category
struct Category: Codable {
    let sysName, name: String
}

// MARK: - Contacts
struct Contacts: Codable {
    let phones: [Phone]
    let email: String
    let website: String
}

// MARK: - Phone
struct Phone: Codable {
    let comment, value: String
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let culturarf, eipskID: Int

    enum CodingKeys: String, CodingKey {
        case culturarf
        case eipskID = "eipskId"
    }
}

// MARK: - ExternalInfo
struct ExternalInfo: Codable {
    let serviceName: String
    let url: String
}

// MARK: - Image
struct Image: Codable {
    let title: String
    let url: String
}

// MARK: - Organization
struct Organization: Codable {
    let address: OrganizationAddress
    let name: String
}

// MARK: - OrganizationAddress
struct OrganizationAddress: Codable {
    let fullAddress: String
    let street: String
    
}

// MARK: - WorkingSchedule
struct WorkingSchedule: Codable {
    let to, from: String
    
}


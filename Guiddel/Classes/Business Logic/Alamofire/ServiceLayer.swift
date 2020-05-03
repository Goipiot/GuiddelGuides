//
//  ServiceLayer.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Alamofire
import Foundation

final class ServiceLayer {
    
    static let shared = ServiceLayer()
    
    let apiClient: ApiClient
    let museumService: MuseumService
    
    init() {
        apiClient = ApiClient()
        museumService = MuseumService(client: apiClient)
    }
}

//
//  MuseumService.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Alamofire

class MuseumService {
    
    let client: ApiClient
    
    init(client: ApiClient) {
        self.client = client
    }
    
    func getMuseums(completionHandler: @escaping (Main?, Error?) -> Void) {
        return self.client.request(with: MuseumEndpoint()) { (response, error) in
            completionHandler(response, error)
        }
    }
}

//
//  MuseumEndpoint.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Alamofire

struct MuseumEndpoint: Endpoint {
    
    typealias Response = Main
    
    func request() throws -> DataRequest {
    
        URLCache.shared.removeAllCachedResponses()
        let baseUrl = URL(string: "https://opendata.mkrf.ru")!
        let loginUrl = baseUrl.appendingPathComponent("/v2/museums/$")
        var headers: HTTPHeaders = ["X-API-KEY": "932f144d433cdcdaa08b7b2629b1d38641095114f8b10a66c653e7dcfa5031e0"]
        
        let params: Parameters = [
            "f": "{\"data.general.locale.name\":{\"$contain\":\"Москва\"}}"
        ]
        let manager = Alamofire.Session.default.request(loginUrl,
                               method: .get,
                               parameters: params,
                               encoding: URLEncoding(destination: .methodDependent),
                               headers: headers)
        return manager.self
    }
    
    func parse(response: Data) throws -> Main {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var result: Main
        do {
            result = try decoder.decode(Main.self, from: response)
        } catch let error {
            print(error)
            throw error
        }
        return result
    }
}

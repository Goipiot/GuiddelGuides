//
//  Endpoint.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Alamofire

protocol Endpoint {
    
    associatedtype Response
    
    func request() throws -> DataRequest

    func parse(response: Data) throws -> Response
    
}

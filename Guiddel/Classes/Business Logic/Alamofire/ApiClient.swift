//
//  ApiClient.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

struct ApiClient {
    
    func request<Request>(
        with request: Request,
        completionHandler: @escaping (Request.Response?, BaseError?) -> Void) where Request: Endpoint {
        do {
            let newRequest = try request.request()
//            newRequest.responseJSON { (response) in
//                switch response.result {
//                       case .success(let value):
//                            print(value)
//                       case .failure:
//                            completionHandler(nil, BaseError.networkError)
//                       }
//            }
            newRequest.responseData { (response) in
                switch response.result {
                case .success(let data):
                    print(data)
                    if response.response?.statusCode == 200 {
                                            do {
                                                let successResponse = try request.parse(response: data)
                                                completionHandler(successResponse, nil)
                                            } catch {
                                                completionHandler(nil, BaseError.parseError)
                                            }
                                            
                                        } else if response.response?.statusCode == 401 {
                                            completionHandler(nil, BaseError.invalidToken)
                                        }
                                        
                    //                    let cstorage = HTTPCookieStorage.shared
                    //                    if let cookies = cstorage.cookies(for: (response.request?.url)!) {
                    //                        for cookie in cookies {
                    //                            cstorage.deleteCookie(cookie)
                    //                        }
                    //                    }

                case .failure:
                    completionHandler(nil, BaseError.networkError)
                }
            }
        } catch {
            completionHandler(nil, BaseError.networkError)
        }
    }
}

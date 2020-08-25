//
//  GuideRequestFirestoreManager.swift
//  Guiddel
//
//  Created by Anton Danilov on 07.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct GuideRequestFirestoreManager {
    // Private init
    private init(){}
    
    static let shared = GuideRequestFirestoreManager()
    
    private let requestsDB = Firestore.firestore().collection("requests")
    
    private let decoder = JSONDecoder()
    
    func send(object: GuideRequest, completion: @escaping(Error?) -> Void) {
        do {
            let ref = try requestsDB.addDocument(from: object)
            UserFirestoreManager.shared.addUserRequest(requestID: ref.documentID) { err in
                if let err = err {
                    completion(err)
                } else {
                    completion(nil)
                }
            }
        } catch let error {
            completion(error)
        }
    }
    
    func get(completion: @escaping(Error?, [GuideRequest]?) -> Void) {
        requestsDB.addSnapshotListener { querySnapshot, err in
            if let err = err {
                completion(err, nil)
            } else {
                var requestArray: [GuideRequest] = []
                for document in querySnapshot!.documents {
                    do {
                        let jsonData = try? JSONSerialization.data(withJSONObject: document.data())
                        var request = try self.decoder.decode(GuideRequest.self, from: jsonData!)
                        request.reqId = document.documentID
                        requestArray.append(request)
                    } catch let error {
                        completion(error, nil)
                    }
                }
                completion(nil, requestArray)
            }
        }
    }
    
    func deleteRequest(reqId: String, completion: @escaping(Error?) -> Void) {
        requestsDB.document(reqId).delete { err in
            if let err = err {
                completion(err)
            } else {
                completion(nil)
            }
        }
    }
}

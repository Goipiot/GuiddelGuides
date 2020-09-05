//
//  MuseumFirestoreManager.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 03.09.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Firebase
import FirebaseFirestoreSwift

class MuseumFirestoreManager {
    static let shared = MuseumFirestoreManager()
    
    private let museumDB = Firestore.firestore().collection("museums")
    
    private let decoder = JSONDecoder()
    
    // Private init
    private init() {}
    
    func verifyGuide(museumCode: String, completion: @escaping(Error?) -> Void) {
        print(museumCode)
        museumDB.whereField("secretCode", isEqualTo: museumCode).getDocuments { querySnapshot, err in
            if let err = err {
                completion(err)
            } else {
                var museumArray: [Museum] = []
                for document in querySnapshot!.documents {
                    do {
                        let jsonData = try? JSONSerialization.data(withJSONObject: document.data())
                        var museum = try self.decoder.decode(Museum.self, from: jsonData!)
                        museum.mid = document.documentID
                        museumArray.append(museum)
                    } catch let error {
                        completion(error)
                    }
                }
                print(museumArray.count)
                if let museum = museumArray.first {
                    UserFirestoreManager.shared.verifyGuide(museumId: museum.mid!) { err in
                        if let err = err {
                            completion(err)
                        } else {
                            completion(nil)
                        }
                    }
                } else {
                    completion(BaseError.invalidSecretKey)
                }
                
            }
        }
    }
}

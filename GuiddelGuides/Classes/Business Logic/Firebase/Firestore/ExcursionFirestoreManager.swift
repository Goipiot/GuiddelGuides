//
//  ExcursionFirestoreManager.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 07.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Firebase
import FirebaseFirestoreSwift

struct ExcursionFirestoreManager {
    // Private init
    private init() {}
    
    static let shared = ExcursionFirestoreManager()
    
    private let requestsDB = Firestore.firestore().collection("excursions")
    
    private let decoder = JSONDecoder()
    
    func send(object: Excursion, completion: @escaping(Error?) -> Void) {
        do {
            try requestsDB.addDocument(from: object)
//            let uid = object.users.keys.first!
//            UserFirestoreManager.shared.addExcursion(excursion: object,
//                                                     excursionID: ref.documentID,
//                                                     userID: uid) { err in
//                if let err = err {
//                    completion(err)
//                } else {
//                    completion(nil)
//                }
                completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    func get(completion: @escaping(Error?, [Excursion]?) -> Void) {
        requestsDB.addSnapshotListener { querySnapshot, err in
            if let err = err {
                completion(err, nil)
            } else {
                var excursionArray: [Excursion] = []
                for document in querySnapshot!.documents {
                    do {
                        let jsonData = try? JSONSerialization.data(withJSONObject: document.data())
                        let excursion = try self.decoder.decode(Excursion.self, from: jsonData!)
                        excursionArray.append(excursion)
                    } catch let error {
                        completion(error, nil)
                    }
                }
//                let formatter = DateFormatter.get(with: .fullWithTime)
//                excursionArray.sorted {
//                    let date1 = formatter.date(from: $0.date)
//                    let date2 = formatter.date(from: $1.date)
//                    return
//                }
                let result = excursionArray.sorted (by: {$0.day.compare($1.day, options: .numeric) == .orderedDescending})
                completion(nil, result)
            }
        }
    }
}

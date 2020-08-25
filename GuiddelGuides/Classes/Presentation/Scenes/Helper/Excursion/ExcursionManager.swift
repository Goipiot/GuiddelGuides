//
//  ExcursionManager.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 07.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

struct ExcursionManager {
    static var shared = ExcursionManager()
    
//    func createExcursion(request: GuideRequest, competion: @escaping(Error?) -> Void) {
//        UserFirestoreManager.shared.getUser(with: request.userId) { user, err in
//            if let err = err {
//                competion(err)
//            } else {
//                if let user = user {
//                    UserFirestoreManager.shared.getUser { guide, err in
//                        if let err = err {
//                            competion(err)
//                        } else {
//                            if let guide = guide {
//                                let excursion = Excursion(users: ["\(user.uid)": user],
//                                                          guide: guide,
//                                                          date: request.date,
//                                                          museum: request.museum)
//                                ExcursionFirestoreManager.shared.send(object: excursion) { err in
//                                    if let err = err {
//                                        competion(err)
//                                    } else {
//                                        guard let requestId = request.reqId else { return }
//                                        GuideRequestFirestoreManager.shared.deleteRequest(reqId: requestId) { err in
//                                            if let err = err {
//                                                competion(err)
//                                            } else {
//                                                competion(nil)
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
}

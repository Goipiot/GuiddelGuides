//
//  Notification.Name.swift
//  Guiddel
//
//  Created by Anton Danilov on 27.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let didReceiveUserData = Notification.Name("didReceiveData")
    static let didChangedMuseumRequest = Notification.Name("didChangedMuseumRequest")
    static let didChangedMuseumRequestName = Notification.Name("didChangedMuseumRequestName")
    static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
}


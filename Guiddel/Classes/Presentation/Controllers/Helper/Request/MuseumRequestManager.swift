//
//  MuseumRequestManager.swift
//  Guiddel
//
//  Created by Anton Danilov on 02.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

struct MuseumRequestManager {
    static var shared = MuseumRequestManager()
    
    var museumRequest: GuideRequest = GuideRequest() {
        didSet {
            NotificationCenter.default.post(name: .didChangedMuseumRequest, object: museumRequest)
        }
    }
    
    // MARK: - Public Properties
    var museum: String? {
        didSet {
            NotificationCenter.default.post(name: .didChangedMuseumRequestName, object: museum)
        }
    }
    var time: String? {
        didSet {
        }
    }
    
    // MARK: - Public Methods
    
    
    public func saveNewDrink(completion: @escaping (Bool) -> Void) {
    }
    
    public func reloadData() {
    }
    
    // MARK: - Private Methods
    
    private func checkAllFields() -> Bool {
        return true
    }
    
    
}

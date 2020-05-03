//
//  NameHelper.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

class NameHelper {
    static let shared = NameHelper()

    private init() {}
    
    func getName(from fullName: String) -> String {
        var name = fullName
        if fullName.contains("ГБУК г. Москвы") {
            name = fullName.components(separatedBy: "ГБУК г. Москвы ")[1]
        } else if fullName.contains("ГБУК"){
            name = fullName.components(separatedBy: "ГБУК ")[1]
        } else if fullName.contains("ФГБУК"){
            name = fullName.components(separatedBy: "ФГБУК ")[1]
        } else if fullName.contains("ГАУК ГМЗ"){
            name = fullName.components(separatedBy: "ГАУК ГМЗ ")[1]
        } else if fullName.contains("ГАУ"){
            name = fullName.components(separatedBy: "ГАУ ")[1]
        } else if fullName.contains("ГАУ г. Москвы"){
            name = fullName.components(separatedBy: "ГАУ г. Москвы ")[1]
        } else if fullName.contains("ФГБУ"){
            name = fullName.components(separatedBy: "ФГБУ ")[1]
        } else if fullName.contains("РОО"){
            name = fullName.components(separatedBy: "РОО ")[1]
        } else if fullName.contains("НОУ"){
            name = fullName.components(separatedBy: "НОУ ")[1]
        }
        if name.contains("«"), fullName.contains("»") {
            if name.first == "«" {
                name = String(name.dropFirst())
            }
//            let part = fullName.components(separatedBy: "«")[1]
//            name = part.components(separatedBy: "»")[1]
            
        }
        return name
    }
}

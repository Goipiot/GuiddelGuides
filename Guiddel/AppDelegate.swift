//
//  AppDelegate.swift
//  Guiddel
//
//  Created by Anton Danilov on 27.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    checkIfUserLogged()
    return true
  }
    
}

// MARK:- Handle Logging
extension AppDelegate {
    func logIn() {
        self.window?.rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()
    }
    func logOut() {
        self.window?.rootViewController = UIStoryboard(name: "Login", bundle: Bundle.main).instantiateInitialViewController()
    }
    
    func checkIfUserLogged() {
        if Auth.auth().currentUser == nil {
            let rootController = UIStoryboard(name: "Login", bundle: Bundle.main).instantiateInitialViewController()
            self.window?.rootViewController = rootController
        } else {
            let rootController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()
            self.window?.rootViewController = rootController
        }
    }
}

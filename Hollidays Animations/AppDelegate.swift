//
//  AppDelegate.swift
//  Hollidays Animations
//
//  Created by Bruno Silva on 05/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        
        window = UIWindow()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()        
        let layout = SpringyFlowLayout()
        window?.rootViewController = UINavigationController(rootViewController: ViewController(collectionViewLayout: layout))

        return true
    }

}


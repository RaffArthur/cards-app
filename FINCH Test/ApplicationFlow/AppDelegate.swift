//
//  AppDelegate.swift
//  FINCH Test
//
//  Created by Arthur Raff on 21.07.2021.
//

import UIKit

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = FeedViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}


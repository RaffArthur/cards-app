//
//  AppDelegate.swift
//  Cards App
//
//  Created by Arthur Raff on 21.07.2021.
//

import UIKit
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let window = window else { return false }
            
        window.rootViewController = UINavigationController(rootViewController: FeedViewController())
        window.makeKeyAndVisible()
        
        return true
    }
}

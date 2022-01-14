//
//  AppDelegate.swift
//  OtterScaleiOSExamples
//
//  Created by Андрей Чернышев on 10.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}


//
//  AppDelegate.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 10/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootViewController()
        return true
    }
    
    private func setupRootViewController() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: AccountTransactionsViewController())
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
    }
}


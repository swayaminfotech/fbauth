//
//  AppDelegate.swift
//  FBAuth
//
//  Created by Swayam Infotech on 23/09/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import UIKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationVC = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let vc = Util.getStoryboard().instantiateViewController(withIdentifier: "HomeVC")
        navigationVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()

        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        ApplicationDelegate.shared.application(
            app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,  annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        return true
    }
}

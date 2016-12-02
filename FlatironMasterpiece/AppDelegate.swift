
//  AppDelegate.swift
//  FlatironMasterpiece
//
//  Created by Elias Miller on 11/14/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import CoreData
import GooglePlaces
import CoreLocation
import Firebase
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var navController: UINavigationController?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        FIRApp.configure()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Override point for customization after application launch.
        GMSPlacesClient.provideAPIKey(gpApiKey)

        FIRApp.configure()

        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)


        //MARK: - sets up the navigation controller for our app



//        navController = UINavigationController()
//        var loginVC = LogInViewController()
//        let frame = UIScreen.main.bounds
//        window = UIWindow(frame: frame)
//        self.navController?.pushViewController(loginVC, animated: false)
//        self.window?.rootViewController = navController
//        self.window?.backgroundColor = phaedraDarkGreen
//        self.window?.makeKeyAndVisible()

//        print("app delegate working")
  
        //MARK: - sets the initial view controller

      let initialViewController = UserTagAlongsTableViewController()

       let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)

        if let window = window {
            window.rootViewController = initialViewController
            window.makeKeyAndVisible()
        }


        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {

        return true

//        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])

      //  return handled

    }
//    func application(_ application: UIApplication, open url: URL, options: protocol<UIApplicationOpenURLOptionsKey, Any>) -> Bool {
//        var handled = FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey], annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
//        // Add any custom logic here.
//        return handled
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//
//  AppDelegate.swift
//  VideoPlayer
//
//  Created by 荒木 敦 on 2016/12/03.
//  Copyright © 2016年 WishMatch, Inc. All rights reserved.
//

import UIKit

func print(items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        Swift.print(items[0], separator:separator, terminator: terminator)
    #endif
}

func NSLog(message:String){
    #if DEBUG
        Foundation.NSLog(message)
    #endif
}

func NSLog(format:String, _ args:CVarArgType...){
    #if DEBUG
        Foundation.NSLog(String(format: format, arguments: args))
    #endif
}

@UIApplicationMain
class AppDelegate: UIResponder {

    var window: UIWindow?
}

extension AppDelegate: UIApplicationDelegate {
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let videoPlayerListViewController = VideoPlayerListViewController()
        
        let navigationController = UINavigationController(rootViewController: videoPlayerListViewController)
        
        // Set isShouldAutorotate flag
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(false, forKey: isShouldAutorotate)

        //縦向きの判定.
        userDefaults.setBool(false, forKey: isLandscape)
        
        navigationController.shouldAutorotate()
        
        self.window?.rootViewController = navigationController
        
        // Shows the window and makes it the key window.
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


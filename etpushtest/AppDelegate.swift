//
//  AppDelegate.swift
//  etpushtest
//
//  Created by 楊野 勇智 on 2015/08/20.
//  Copyright (c) 2015年 salesforce.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ExactTargetOpenDirectDelegate {

    var window: UIWindow?

    #if DEBUG
        let etAppId = "3c91101b-af42-41d3-a57e-218df1ce85b6"
        let etAccessToken = "7hwn9yfzkudf6qnzm27dy2ud"
    #else
        let etAppId = "ccbcd89b-3f25-435e-a5dc-0ecc29fe4e5c"
        let etAccessToken = "b6jstebyrbde49zv54jsp8fd"
    #endif

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        var error : NSError?
        let success : Bool = ETPush.pushManager().configureSDKWithAppID(etAppId,
            andAccessToken: etAccessToken,
            withAnalytics: true,
            andLocationServices: true,
            andCloudPages: true,
            withPIAnalytics: true,
            error: &error
        )
        if success {
            ETPush.pushManager().setOpenDirectDelegate(self)
            ETPush.pushManager().applicationLaunchedWithOptions(launchOptions)
        }
        else {
            let alert = UIAlertController(title: "Error", message: error != nil ? error!.description : "unknown error" , preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: {( action : UIAlertAction!) in
                alert.dismissViewControllerAnimated(true, completion: nil)
                }
            )
            alert.addAction(okAction)
        }
        
        let settings = UIUserNotificationSettings(forTypes: .Alert | .Badge | .Sound, categories: nil)
        ETPush.pushManager().registerUserNotificationSettings(settings)
        ETPush.pushManager().registerForRemoteNotifications()
        ETPush.setETLoggerToRequiredState(true)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Delegates for Push Notification
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        ETPush.pushManager().didRegisterUserNotificationSettings(notificationSettings)
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        ETPush.pushManager().registerDeviceToken(deviceToken)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        ETPush.pushManager().applicationDidFailToRegisterForRemoteNotificationsWithError(error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        println("userInfo =  \(userInfo)")
        ETPush.pushManager().handleNotification(userInfo, forApplicationState: application.applicationState)
    }
    
    // MARK: - ExactTargetOpenDelegate
    func didReceiveOpenDirectMessageWithContents(payload: String!) {
        
    }

}


//
//  AppDelegate.swift
//  knapsack
//
//  Created by manatee on 7/28/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  
  let masterList = try! Realm().objects(ItemList).filter("id = '1'")
  let customListFromAppDelegate = try! Realm().objects(ItemList).filter("id = '2'")
  
  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    UITableViewCell.appearance().backgroundColor = UIColor.clearColor()
    checkIfMasterListExists()
    
    let config = Realm.Configuration(
      schemaVersion: 1,
      
      migrationBlock: { migration, oldSchemaVersion in
      if (oldSchemaVersion < 1) {
      
      }
    
    })
    
    Realm.Configuration.defaultConfiguration = config
    
    // for migrating database if needed
    let realm = try! Realm()
    
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
  
  func checkIfMasterListExists() {

    if masterList.count == 0 {
      print("Master List Being Created")
      DataManager.populateRealm()
    } else {
      _ = masterList.first!
      print("Master List Exists")
    }
  }


}


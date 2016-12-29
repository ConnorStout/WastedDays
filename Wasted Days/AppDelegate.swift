//
//  AppDelegate.swift
//  Wasted Days
//
//  Created by Connor Stout on 7/4/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var allDays:[Day] = []
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        saveToUserDefaults()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveToCoreData()
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "Unanonymous.Wasted_Days" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "Wasted_Days", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support
    
    
    func saveToUserDefaults() {
        print("got here")
        let fetch: NSFetchRequest<Device>
        
        if #available(iOS 10.0, OSX 10.12, *) {
            print("ios 10")
            fetch = NSFetchRequest<Device>(entityName: "Device")
        } else {
            fetch = NSFetchRequest(entityName: "Device")
        }
        print("got here2")
        var retrieved:[Device]  = []
        
        do{
            print("got here3")
          
            retrieved = try managedObjectContext.fetch(fetch) 
            print("got here4")
            
        } catch let error {
            print(error.localizedDescription)
        }
        print("got here3")
        print(retrieved)
        for i in 0..<retrieved.count {
            
            let index:Int = doesDayExist(Int((retrieved[i] as AnyObject).value(forKeyPath: "yearMonthDay")! as! NSNumber))
                
            if(index == (-1)){
                let newDay:Day = Day(yearMonthDay: Int((retrieved[i] as AnyObject).value(forKeyPath: "yearMonthDay")! as! NSNumber))
                let hour:Int = Int((retrieved[i] as AnyObject).value(forKeyPath: "hour")! as! NSNumber)
                newDay.types[hour] = Int((retrieved[i] as AnyObject).value(forKeyPath: "type")! as! NSInteger)
                newDay.tasks[hour] = String((retrieved[i] as AnyObject).value(forKeyPath: "task")! as! NSString)
                allDays.append(newDay)
                
            }else{
                let hour:Int = Int((retrieved[i] as AnyObject).value(forKeyPath: "hour")! as! NSNumber)
                allDays[index].tasks[hour] = String((retrieved[i] as AnyObject).value(forKeyPath: "task")! as! NSString)
                allDays[index].types[hour] = Int((retrieved[i] as AnyObject).value(forKeyPath: "type")! as! NSInteger)
            }
            
            
            
        }
        
        //let fetch2:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Goals")
        let fetch2:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Goals")
        
        var retrieved2:[Goals] = []
        
        do{
            retrieved2 = try managedObjectContext.fetch(fetch2) as! [Goals]
            
        } catch {
            print(error)
            
        }
        
        for i in 0..<retrieved2.count {
            
      //for _ in 1...power {
            let index:Int = doesDayExist(Int((retrieved2[i]).value(forKeyPath: "yearMonthDay")! as! NSNumber))
            
            if(index == (-1)){
                
            }else{
                allDays[index].setGoals(String((retrieved2[i] as AnyObject).value(forKeyPath: "goals")! as! NSString))
                allDays[index].setGoalsDone(String((retrieved2[i] as AnyObject).value(forKeyPath: "goalsDone")! as! NSString))
            }
            
            
            
        }
        
      
    }
    func doesDayExist(_ input:Int)->Int{
        
        for i in 0 ..< allDays.count {
            if(allDays[i].yearMonthDay==input){
                return i;
                
            }
            
            
        }
        return -1
        
    }
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    func saveToCoreData(){
        for i in 0..<self.allDays.count {
            for j in 0..<24 {
              print(self.allDays)
                let saved = NSEntityDescription.insertNewObject(forEntityName: "Device", into: self.managedObjectContext) 
       
                saved.setValue(self.allDays[i].yearMonthDay, forKey: "yearMonthDay")
 
                saved.setValue(j, forKey: "hour")
             
                saved.setValue(self.allDays[i].tasks[j], forKey: "task")
         
                saved.setValue(self.allDays[i].types[j], forKey: "type")
                
            }
            
            
        }
        var error : NSError? = nil
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }

}


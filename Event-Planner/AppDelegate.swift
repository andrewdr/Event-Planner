//
//  AppDelegate.swift
//  Event-Planner
//
//  Created by The Clout on 12/5/19.
//  Copyright © 2019 Draper Web Services. All rights reserved.
//

import UIKit
import CoreData
import Amplify
import AmplifyPlugins

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
            let apiPlugin = AWSAPIPlugin(modelRegistration: AmplifyModels())
        do {
            try Amplify.add(plugin: apiPlugin)
            try Amplify.configure()
            print("Amplify initialized")
        } catch {
            print("Failed to configure Amplify \(error)")
        }
        return true
    }
    
    func apiMutate() {
        let createEvent = CreateEvent(from: "createEvent")
        Amplify.API.mutate(of: createEvent, type: .create) { (event) in
            switch event {
            case .completed(let result):
                switch result {
                case .success(let createEvent):
                    print("API Mutate successful, created createEvent: \(createEvent)")
                case .failure(let error):
                    print("Completed with error: \(error.errorDescription)")
                }
            case .failed(let error):
                print("Failed with error \(error.errorDescription)")
            default:
                print("Unexpected event")
            }
        }
    }
    
    func apiQuery(id: String) {
        Amplify.API.query(from: CreateEvent.self, byId: id) { (event) in
            switch event {
            case .completed(let result):
                switch result {
                case .success(let createEvent):
                    guard let createEvent = createEvent else {
                        print("API Query completed but missing createEvent")
                        return
                    }
                    print("API Query successful, got createEvent: \(createEvent)")
                case .failure(let error):
                    print("Completed with error: \(error.errorDescription)")
                }
            case .failed(let error):
                print("Failed with error \(error.errorDescription)")
            default:
                print("Unexpected event")
            }
        }
    }
    
    func createSubscription() {
        let subscriptionOperation = Amplify.API.subscribe(from: CreateEvent.self, type: .onCreate) { (event) in
            switch event {
            case .inProcess(let subscriptionEvent):
                switch subscriptionEvent {
                case .connection(let subscriptionConnectionState):
                    print("Subsription connect state is \(subscriptionConnectionState)")
                case .data(let result):
                    switch result {
                    case .success(let todo):
                        print("Successfully got createEvent from subscription: \(todo)")
                    case .failure(let error):
                        print("Got failed result with \(error.errorDescription)")
                    }
                }
            case .completed:
                print("Subscription has been closed")
            case .failed(let error):
                print("Got failed result with \(error.errorDescription)")
            default:
                print("Should never happen")
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Event_Planner")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


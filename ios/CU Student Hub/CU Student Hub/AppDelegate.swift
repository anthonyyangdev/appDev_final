//
//  AppDelegate.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/19/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit
import CoreData
import GoogleSignIn
import Firebase


// Set debug to true and provide the view Controller to test that specific View Controller
let userDefaults = UserDefaults.standard

let encoder = JSONEncoder()
let decode = JSONDecoder()

let debug = false  // If debug == false, then the google sign in screen will appear first.
let testController: UIViewController? = HubViewController()
//    MessengerViewController(chatName: "Apples")


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let user = user, error == nil else {return}
        
        System.currentUser = getUsername(email: user.profile.email)
        System.name = user.profile.name
        System.userImage = user.profile.hasImage ? user.profile.imageURL(withDimension: 1080) : nil
        
        if let name = System.name, let netid = System.currentUser {
            NetworkManager.addProfile(of: name, with: netid) {
                print("User is in the database")
            }
            NetworkManager.getFavoriteLocations(for: netid) { locations in
                var favorites: [Location] = []
                var dictionary: [String: Location] = [:]
                for loc in LocationInfo.array {
                    let name = loc.name.replacingOccurrences(of: " ", with: "_")
                    for l in locations {
                        if l.location_name == name {
                            favorites.append(loc)
                            dictionary[name] = loc
                            break
                        }
                    }
                }
                System.favLocation = dictionary
            }
        }
        
        if let url = System.userImage {
            getData(from: url) { (data, response, error) in
                guard let data = data, error == nil else {return}
                DispatchQueue.main.async {
                    System.userProfilePic = UIImage(data: data)
                }
            }
        } else {
            print("\n\nNo profile Image found!\n\n")
        }
        
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("\n\n\nSigned Out\n\n\n")
    }
    
    private func getUsername(email: String) -> String {
        let components = email.components(separatedBy: "@")
        return components[0]
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
    }
    

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if (!debug) {
            FirebaseApp.configure()
            GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
            GIDSignIn.sharedInstance()?.delegate = self
        
            window?.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController() ?? UIViewController()
            window?.makeKeyAndVisible()
        
            if GIDSignIn.sharedInstance().hasAuthInKeychain() {
                DispatchQueue.main.async {
                    GIDSignIn.sharedInstance()?.signInSilently()
                }
            } else {
                window?.rootViewController = SignInViewController()
            }
        } else {
            if let controller = testController {
                window?.rootViewController = UINavigationController(rootViewController: controller)
                window?.makeKeyAndVisible()
            } else {
                print("\n\n\nProvide a non-nil value in the global variable testController.\n\n\n")
            }

        }
        return true
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = UINavigationController(rootViewController: ViewController())
//        window?.makeKeyAndVisible()
    }

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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CU_Student_Hub")
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

    func saveContext() {
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


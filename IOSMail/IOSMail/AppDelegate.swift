//
//  AppDelegate.swift
//  IOSMail
//
//  Created by student on 2020-10-19.
//

import UIKit
import GoogleSignIn
import RealmSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    let realm = RealmService.shared.realm
    
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
		if let error = error { 
			if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
				print("The user has not signed in before or they have since signed out.")
			} else {
				print("\(error.localizedDescription)")
			}
			// [START_EXCLUDE silent]
			NotificationCenter.default.post(
				name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
			// [END_EXCLUDE]
			return
		}
		// Perform any operations on signed in user here.
//		
		NotificationCenter.default.post(
			name: Notification.Name(rawValue: "ToggleAuthUINotification"),
			object: nil,
			userInfo: ["statusText": "nothing"])
		
	}
	
	// [START disconnect_handler]
	func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
			  withError error: Error!) {
		// Perform any operations when the user disconnects from app here.
		// [START_EXCLUDE]
		NotificationCenter.default.post(
			name: Notification.Name(rawValue: "ToggleAuthUINotification"),
			object: nil,
			userInfo: ["statusText": "User has disconnected."])
		// [END_EXCLUDE]
	}
	// [END disconnect_handler]




    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let scopes = ["https://mail.google.com/"]
		GIDSignIn.sharedInstance().clientID = "662449896826-13dpc48tgddtki7f7ad1pilpq13u8hnh.apps.googleusercontent.com"
		GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.scopes = scopes
      
        do {
            let _ = try Realm()
        } catch {
            print("Error initialising new Realm, \(error)")
        }
        
        return true
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






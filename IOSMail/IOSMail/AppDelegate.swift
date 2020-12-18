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
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
		if let error = error { 
			if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
				print("The user has not signed in before or they have since signed out.")
			} else {
				print("\(error.localizedDescription)")
			}
			NotificationCenter.default.post(
				name: Notification.Name(rawValue: "signInStatus"), object: nil, userInfo: nil)
			return
		}
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "signInStatus"),
            object: nil,
            userInfo: ["statusText": "Name"])
	}
	
	func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
			  withError error: Error!) {
		NotificationCenter.default.post(
			name: Notification.Name(rawValue: "signInStatus"),
			object: nil,
			userInfo: ["statusText": "User has disconnected."])
	}
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let scopes = ["https://mail.google.com/","https://www.googleapis.com/auth/gmail.send"]
		GIDSignIn.sharedInstance().clientID =
			"662449896826-2qlnkc1bpigf96oqkvbnd2sh25ebqfa3.apps.googleusercontent.com"
			//"662449896826-13dpc48tgddtki7f7ad1pilpq13u8hnh.apps.googleusercontent.com"
		GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.scopes = scopes
        
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "file:")
        
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
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

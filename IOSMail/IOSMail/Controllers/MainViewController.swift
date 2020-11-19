//
//  ViewController.swift
//  IOSMail
//
//  Created by student on 2020-10-19.
//

import UIKit
import GoogleSignIn
import RealmSwift

class MainViewController: UIViewController {

	@IBOutlet weak var signInButton: GIDSignInButton!
	@IBAction func signInBut(_ sender: Any) {

		//GIDSignIn.sharedInstance().signIn()
		/*if ((GIDSignIn.sharedInstance()?.hasPreviousSignIn()) != nil) {
			GIDSignIn.sharedInstance()?.restorePreviousSignIn()*/
			if let mvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView") as? HomeViewController {
				mvc.modalPresentationStyle = .fullScreen
			self.present(mvc, animated: true, completion: nil)
			}
		/*} else {
			GIDSignIn.sharedInstance()?.signIn()
		}*/
	}

	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		GIDSignIn.sharedInstance()?.presentingViewController = self

		// Automatically sign in the user.
		//GIDSignIn.sharedInstance()?.restorePreviousSignIn()


		// [START_EXCLUDE]
		NotificationCenter.default.addObserver(self,
											   selector: #selector(MainViewController.receiveToggleAuthUINotification(_:)),
											   name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
											   object: nil)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(MainViewController.receiveToggleAuthUINotification(_:)),
											   name: NSNotification.Name(rawValue: "GetMailNotification"),
											   object: nil)

		//statusText.text = "Initialized Swift app..."
		//toggleAuthUI()
    }

	// [START disconnect_tapped]
	@IBAction func didTapDisconnect(_ sender: AnyObject) {
		GIDSignIn.sharedInstance().disconnect()
		// [START_EXCLUDE silent]
		//statusText.text = "Disconnecting."
		// [END_EXCLUDE]
	}
	// [END disconnect_tapped]

	@IBAction func didTapSignOut(_ sender: Any) {
		GIDSignIn.sharedInstance().signOut()
		// [START_EXCLUDE silent]
		//statusText.text = "Signed out."
		//toggleAuthUI()
		// [END_EXCLUDE]
	}

	func toggleAuthUI() {
		if let _ = GIDSignIn.sharedInstance()?.currentUser?.authentication {
			// Signed in
			//signInButton.isHidden = true
			//signOutButton.isHidden = false
			//disconnectButton.isHidden = false
			print("toggleAuthUI() called. \(String(describing: GIDSignIn.sharedInstance()?.currentUser?.userID))")
		} else {
			//signInButton.isHidden = false
			//signOutButton.isHidden = true
			//disconnectButton.isHidden = true
			//statusText.text = "Google Sign in\niOS Demo"
		}
	}
	// [END toggle_auth]


	override var preferredStatusBarStyle: UIStatusBarStyle {
		return UIStatusBarStyle.lightContent
	}

	deinit {
		NotificationCenter.default.removeObserver(self,
												  name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
												  object: nil)
		NotificationCenter.default.removeObserver(self,
												  name: NSNotification.Name(rawValue: "GetMailNotification"),
												  object: nil)
	}

	@objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
		//if notification.name.rawValue == "GetMailNotification" {
		//	print("Getting mail")
		//}

		if notification.name.rawValue == "ToggleAuthUINotification" {
			//self.toggleAuthUI()
			if notification.userInfo != nil {
				guard let userInfo = notification.userInfo as? [String:String] else { return }
				//performSegue(withIdentifier: "HomeView", sender: nil)
				if let mvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeView") as? HomeViewController {
					mvc.modalPresentationStyle = .fullScreen
					//mvc.sb.text = userInfo["statusText"]!
					mvc.inboxText = userInfo["statusText"]!
					self.present(mvc, animated: true, completion: nil)
				}
				print("\(userInfo["statusText"]!)?")
				
				//self.statusText.text = userInfo["statusText"]!
			}
		}
	}
}


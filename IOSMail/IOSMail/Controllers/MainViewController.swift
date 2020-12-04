//
//  ViewController.swift
//  IOSMail
//
//  Created by student on 2020-10-19.
//

import UIKit
import GoogleSignIn
import RealmSwift
import GoogleAPIClientForREST
import GTMSessionFetcher

class MainViewController: UIViewController {
    let gmailService = GTLRGmailService.init()
    var messageList = [GTLRGmail_Message]()
	var messages = [MailData]()

	var mvc : HomeViewController?

	@IBOutlet weak var signInButton: GIDSignInButton!
	@IBAction func signInBut(_ sender: Any) {
       
		GIDSignIn.sharedInstance().signIn()
	       
	}

	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		GIDSignIn.sharedInstance()?.presentingViewController = self

		// Automatically sign in the user.
		GIDSignIn.sharedInstance()?.restorePreviousSignIn()

		NotificationCenter.default.addObserver(self,
           selector: #selector(MainViewController.receiveToggleAuthUINotification(_:)),
           name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
           object: nil)
		NotificationCenter.default.addObserver(self,
           selector: #selector(MainViewController.receiveToggleAuthUINotification(_:)),
           name: NSNotification.Name(rawValue: "GetMailNotification"),
           object: nil)
    }

	// [START disconnect_tapped]
	@IBAction func didTapDisconnect(_ sender: AnyObject) {
		GIDSignIn.sharedInstance().disconnect()
	}
	// [END disconnect_tapped]

	@IBAction func didTapSignOut(_ sender: Any) {
		GIDSignIn.sharedInstance().signOut()
	}

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
//MARK: notification functions
	@objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
		if notification.name.rawValue == "ToggleAuthUINotification" {
			if notification.userInfo != nil {
				guard let userInfo = notification.userInfo as? [String:String] else { return }
				print(userInfo)
                print(GIDSignIn.sharedInstance()?.currentUser)
				if let mvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeView") as? HomeViewController {
					mvc.modalPresentationStyle = .fullScreen

					self.present(mvc, animated: true, completion: nil)
				}

			}
		}
	}
    
 
    func base64urlToBase64(base64url: String) -> String {
        var base64 = base64url
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        if base64.count % 4 != 0 {
            base64.append(String(repeating: "=", count: 4 - base64.count % 4))
        }
        return base64
    }
}

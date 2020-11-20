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
	@IBOutlet weak var signInButton: GIDSignInButton!
	@IBAction func signInBut(_ sender: Any) {
       
		GIDSignIn.sharedInstance().signIn()
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

	@objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
		//if notification.name.rawValue == "GetMailNotification" {
		//	print("Getting mail")
		//}

		if notification.name.rawValue == "ToggleAuthUINotification" {
			//self.toggleAuthUI()
			if notification.userInfo != nil {
				guard let userInfo = notification.userInfo as? [String:String] else { return }
				if let mvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeView") as? HomeViewController {
					mvc.modalPresentationStyle = .fullScreen
					self.present(mvc, animated: true, completion: nil)
				}
				print("\(userInfo["statusText"]!)?")
                listInboxMessages()
			}
		}
	}
    
    
    func listInboxMessages() {
       
        let listQuery = GTLRGmailQuery_UsersMessagesList.query(withUserId: "me")
        listQuery.labelIds = ["INBOX"]

        let authorizer = GIDSignIn.sharedInstance()?.currentUser?.authentication?.fetcherAuthorizer()

        gmailService.authorizer = authorizer
        //gmailService.shouldFetchNextPages = true
        listQuery.maxResults = 1
        
        gmailService.executeQuery(listQuery) { (ticket, response, error) in
            if response != nil {
                self.getFirstMessageIdFromMessages(response: response as! GTLRGmail_ListMessagesResponse)
            } else {
                print("Error: ")
                print(error)
            }
        }
    }
    
    func getFirstMessageIdFromMessages(response: GTLRGmail_ListMessagesResponse) {
        let messagesResponse = response as GTLRGmail_ListMessagesResponse
        do {
            try messagesResponse.messages!.forEach({ (msg) in
                let query = GTLRGmailQuery_UsersMessagesGet.query(withUserId: "me", identifier: msg.identifier!)
                gmailService.executeQuery(query) { [self] (ticket, response, error) in
                    if response != nil {
                        self.messageList.append(response as! GTLRGmail_Message)
                        print("Message: ")
                        self.messageList.forEach { (message) in
                            //get the body of the email and decode it
                            guard let message2 = message.payload!.parts?[0] else
                            {return }
                            let mail = self.base64urlToBase64(base64url: message2.body!.data!)
                            if let data = Data(base64Encoded: mail) {
                                print(String(data: data, encoding: .utf8)!)
                            }
                        }
                        
                    } else {
                        print("Error: ")
                        print(error)
                    }
                }
                
            })
        } catch{
            print("error \(error)")
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

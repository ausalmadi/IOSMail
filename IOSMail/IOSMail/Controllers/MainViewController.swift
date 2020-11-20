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
	//let mailManager = MailManager.shared

	var mvc : HomeViewController?

	@IBOutlet weak var signInButton: GIDSignInButton!
	@IBAction func signInBut(_ sender: Any) {
       
		GIDSignIn.sharedInstance().signIn()
		/*if ((GIDSignIn.sharedInstance()?.hasPreviousSignIn()) != nil) {
			GIDSignIn.sharedInstance()?.restorePreviousSignIn()*/
		/*if mvc == UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView") as? HomeViewController {
				mvc?.modalPresentationStyle = .fullScreen

				self.present(mvc!, animated: true, completion: nil)
			}*/
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
		if notification.name.rawValue == "ToggleAuthUINotification" {
			if notification.userInfo != nil {
				guard let userInfo = notification.userInfo as? [String:String] else { return }
				if let mvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeView") as? HomeViewController {
					mvc.modalPresentationStyle = .fullScreen
					self.present(mvc, animated: true, completion: nil)
				}
			}
		}
	}
    
    
    
    //for test
    /*
    func listInboxMessages() {
       
        let listQuery = GTLRGmailQuery_UsersMessagesList.query(withUserId: "me")
        listQuery.labelIds = ["SENT"]

        let authorizer = GIDSignIn.sharedInstance()?.currentUser?.authentication?.fetcherAuthorizer()

        gmailService.authorizer = authorizer
        //gmailService.shouldFetchNextPages = true
        listQuery.maxResults = 1
        
        gmailService.executeQuery(listQuery) { (ticket, response, error) in
            if response != nil {
//                print("Response: ")
//                print(response)
                self.getFirstMessageIdFromMessages(response: response as! GTLRGmail_ListMessagesResponse)
            } else {
                print("Error: ")
                print(error as Any)
            }
        }
    }
    
    func getFirstMessageIdFromMessages(response: GTLRGmail_ListMessagesResponse) {
        let messagesResponse = response as GTLRGmail_ListMessagesResponse
        print("Latest Message: ")
        print(messagesResponse.messages!.count as Any)
        do {
            try print(messagesResponse.messages!.forEach({ (msg) in
                let query = GTLRGmailQuery_UsersMessagesGet.query(withUserId: "me", identifier: msg.identifier!)
                gmailService.executeQuery(query) { [self] (ticket, response, error) in
                    if response != nil {
//                        print(response)
                        self.messageList.append(response as! GTLRGmail_Message)
                        print("Message: ")
                        self.messageList.forEach { (message) in
                            //get the body of the email and decode it
                            guard let message2 = message.payload!.parts?[0] else
                            {return }
                            let mail = self.base64urlToBase64(base64url: message2.body!.data!)
                            if let data = Data(base64Encoded: mail) {
								let m = MailData(subject: "", from: "", to: "", body:String(data: data, encoding: .utf8)!, date: "")
								self.messages.append(m)
                                print(String(data: data, encoding: .utf8)!)
                            }
                        }

                        
                    } else {
                        print("Error: ")
						print(error as Any)
                    }
                }
//                print(msg.raw)
                
            }))
        } catch{
            print("error \(error)")
        }
             //identifier)
    }*/

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		print(segue.identifier as Any)
		return
		//print("prepare()")
		//if (segue.identifier == "MainToReader") {
			//let vc = segue.destination as! HomeViewController

			//vc.setMessage(msg: messages[self.index])
		//vc.messages = messageList// as [MailData]
		//listInboxMessages()
		//mvc.sb.text = userInfo["statusText"]!
		//					mvc.inboxText = userInfo["statusText"]!
		//for segue: mvc, sender: self)
		//segue.setMessages(msg: self.messages)
		print(messages.count)
		self.messages.forEach { (message) in
			//guard let message2 = message.payload!.parts?[0] else
			//{return }
			//let mail = self.base64urlToBase64(base64url: message2.body!.data!)
			//let mail = self.base64urlToBase64(base64url: message2.headers![0].jsonString())
			//if let data = Data(base64Encoded: mail) {
				print(message)
			//}
		}

		//messageList[0].
		//}

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


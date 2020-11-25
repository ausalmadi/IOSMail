//
//  MailManager.swift
//  iosMail
//
//  Created by David Crispin on 2020-11-03.
//

import Foundation
import GoogleSignIn
import RealmSwift
import GoogleAPIClientForREST

class MailManager{

	private init(){}

	/*var messages = [MailData]()
	static let shared = MailManager()

	let gmailService = GTLRGmailService.init()
	var messageList = [GTLRGmail_Message]()
	//for test

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
	*/
}


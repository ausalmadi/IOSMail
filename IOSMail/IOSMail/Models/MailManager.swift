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

//	let INBOX = "INBOX" // Constants for default mail folders
//	let SENT = "SENT"
//	let DRAFT = "DRAFT"
    
    var mailBox = "INBOX" // One Value for determining the folder to view

	var messages = [MailData]() // Messages array

	var labels = [String]()
	static let shared = MailManager() // Setting up shared instance of Singleton class

	private init(){

	}

	let gmailService = GTLRGmailService.init() // initialize mail service

	var tbview : UITableView? = nil

	func setMessages(msg : [MailData]){
		print("setMessages() message count = \(msg.count)")
		messages = msg
	}

	func settbView(_tbview : UITableView) {
		self.tbview? = _tbview
	}
	
	func listMessages(tableview:UITableView, folder : String) {
		tbview = tableview
		//messages = []

		//let q = GTLRGmailQuery_UsersLabelsList.query(withUserId: "me")
		//print(q.)
		let listQuery = GTLRGmailQuery_UsersMessagesList.query(withUserId: "me")
		listQuery.labelIds = [folder] // folder to view

		// get authorized user
		let authorizer = GIDSignIn.sharedInstance()?.currentUser?.authentication?.fetcherAuthorizer()

		// set mail service authorizer
		gmailService.authorizer = authorizer
		//gmailService.shouldFetchNextPages = true
		//listQuery.maxResults = 5 // set max results to return

		/*gmailService.executeQuery(q) { (ticket, response, error) in
			if response != nil {
				print(response as! GTLRGmail_ListLabelsResponse)
				//self.getFirstMessageIdFromMessages(response: response as! GTLRGmail_ListMessagesResponse)
			} else {
				print("Error: ")
				print(error as Any)
			}
		}*/
		gmailService.executeQuery(listQuery) { (ticket, response, error) in
			if response != nil {
				self.getFirstMessageIdFromMessages(response: response as! GTLRGmail_ListMessagesResponse)
				self.tbview!.reloadData()
			} else {
				print("Error: ")
				print(error as Any)
			}

		}
	}

	func listLabels(tableview:UITableView) {
		tbview = tableview
		//labels = []
		let listQuery = GTLRGmailQuery_UsersLabelsList.query(withUserId: "me")
		//print(q.)
		//let listQuery = GTLRGmailQuery_UsersMessagesList.query(withUserId: "me")
		//listQuery.labelIds = [folder] // folder to view

		// get authorized user
		let authorizer = GIDSignIn.sharedInstance()?.currentUser?.authentication?.fetcherAuthorizer()

		// set mail service authorizer
		gmailService.authorizer = authorizer
		//gmailService.shouldFetchNextPages = true
		//listQuery.maxResults = 5 // set max results to return

		/*gmailService.executeQuery(q) { (ticket, response, error) in
			if response != nil {
				print(response as! GTLRGmail_ListLabelsResponse)
				//self.getFirstMessageIdFromMessages(response: response as! GTLRGmail_ListMessagesResponse)
			} else {
				print("Error: ")
				print(error as Any)
			}
		}*/
		gmailService.executeQuery(listQuery) { (ticket, response, error) in
			if response != nil {
				self.getLabels(response: response as! GTLRGmail_ListLabelsResponse)
				self.tbview!.reloadData()
			} else {
				print("Error: ")
				print(error as Any)
			}

		}
	}

	func getFirstMessageIdFromMessages(response: GTLRGmail_ListMessagesResponse) {
		var from : String = ""
		var to : String = ""
		var date : String = ""
		var subject : String = ""
		var msgtime : String = ""
		let messagesResponse = response as GTLRGmail_ListMessagesResponse
		var messageList = [GTLRGmail_Message]()
		if messagesResponse.messages == nil { return }
		messagesResponse.messages!.forEach({ (msg) in
		let query = GTLRGmailQuery_UsersMessagesGet.query(withUserId: "me", identifier: msg.identifier!)
		gmailService.executeQuery(query) { [self] (ticket, response, error) in
			if response != nil {
				messageList.append(response as! GTLRGmail_Message)

				do {
					try messageList.forEach { (message) in
						//get the body of the email and decode it
						message.payload!.headers?.forEach {( head) in

							if head.name=="Date" {
								let tempdate = self.base64urlToBase64(base64url: head.value ?? "default value")
								let index = tempdate.index(tempdate.startIndex,offsetBy: 17)
								date = tempdate.substring(to: index)
								msgtime = tempdate.substring(from: index)
								//print (date.substring(to: index))
							}
							if head.name=="Subject" {
								subject = self.base64urlToBase64(base64url: head.value ?? "default value")
							}
							if head.name=="From" {
						from = self.base64urlToBase64(base64url: head.value ?? "default value")
					}
					if head.name=="To" {
						to = self.base64urlToBase64(base64url: head.value ?? "default value")
					}
				}

						guard let message2 = message.payload!.parts?[0] else
						{return }
						if (message2.body!.data != nil) {
						let mail = self.base64urlToBase64(base64url: (message2.body!.data!))

						if let data = Data(base64Encoded: mail) {
							//var htmlData = try NSAttributedString(data: data, documentAttributes: nil)
							//htmlData.data()
							//print(htmlData)
							let m = MailData(subject: subject, from: from, to: to, body:String(data: data, encoding: .utf8)!, date: date, time: msgtime)
							self.messages.append(m)
						}
						} else { return }

					}

				}catch {
					print(error as Any)
				}


			} else {
				print("Error: ")
				print(error as Any)
			}
		}

		})

	}

	func getLabels(response: GTLRGmail_ListLabelsResponse) {
		/*var from : String = ""
		var to : String = ""
		var date : String = ""
		var subject : String = ""
		var msgtime : String = ""*/
		var labelList = [GTLRGmail_Label]()
		let messagesResponse = response as GTLRGmail_ListLabelsResponse

		messagesResponse.labels!.forEach({ (msg) in
			let query = GTLRGmailQuery_UsersLabelsGet.query(withUserId: "me", identifier: msg.identifier!)
			gmailService.executeQuery(query) { [self] (ticket, response, error) in
				if response != nil {
					//print(response as! GTLRGmail_Label)
					labelList.append(response as! GTLRGmail_Label)
					print(labelList[labelList.endIndex - 1].identifier ?? "")
					labels.append(labelList[labelList.endIndex - 1].identifier! as String)
					//self.messageList.append(response as! GTLRGmail_Message)

				}

			}
		}


			)
		tbview?.reloadData()


	}

	func base64urlToBase64(base64url: String) -> String {
		var base64 = base64url
			.replacingOccurrences(of: "-", with: "+")
			.replacingOccurrences(of: "_", with: "/")
//		if base64.count % 4 != 0 {
//			base64.append(String(repeating: "=", count: 4 - base64.count % 4))
//		}
		return base64
	}

}


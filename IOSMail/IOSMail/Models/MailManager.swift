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
	static let shared = MailManager() // Setting up shared instance of Singleton class

	let gmailService = GTLRGmailService.init()
	var messageList = [GTLRGmail_Message]()

	func listInboxMessages() {

	let listQuery = GTLRGmailQuery_UsersMessagesList.query(withUserId: "me")
	listQuery.labelIds = ["INBOX"]

	let authorizer = GIDSignIn.sharedInstance()?.currentUser?.authentication?.fetcherAuthorizer()

	gmailService.authorizer = authorizer
	//gmailService.shouldFetchNextPages = true
	//listQuery.maxResults = 5

	gmailService.executeQuery(listQuery) { (ticket, response, error) in
	if response != nil {
	self.getFirstMessageIdFromMessages(response: response as! GTLRGmail_ListMessagesResponse)
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
	let messagesResponse = response as GTLRGmail_ListMessagesResponse

	messagesResponse.messages!.forEach({ (msg) in
	let query = GTLRGmailQuery_UsersMessagesGet.query(withUserId: "me", identifier: msg.identifier!)
	gmailService.executeQuery(query) { [self] (ticket, response, error) in

	if response != nil {
	self.messageList.append(response as! GTLRGmail_Message)

	do {
	try self.messageList.forEach { (message) in
	//get the body of the email and decode it
	message.payload!.headers?.forEach {( head) in

	if head.name=="Date" {
	date = self.base64urlToBase64(base64url: head.value ?? "default value")
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
	let mail = self.base64urlToBase64(base64url: message2.body!.data!)

	if let data = Data(base64Encoded: mail) {
	//var htmlData = try NSAttributedString(data: data, documentAttributes: nil)
	//htmlData.data()
	//print(htmlData)
	let m = MailData(subject: subject, from: from, to: to, body:String(data: data, encoding: .utf8)!, date: date)
	self.messages.append(m)
	}
	}
	}catch {
	print(error as Any)
	}

	tableView.reloadData()
	} else {
	print("Error: ")
	print(error as Any)
	}
	}

	})

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


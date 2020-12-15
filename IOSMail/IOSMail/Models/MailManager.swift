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

	let HTMLMessage = 1
	let PlainMessage = 0

    var mailBox = ""
//    var mailBox1 = "DRAFT"
//    var mailBox2 = "SENT"
    
	var messages = [MailData]() // Messages array
    var messageList = [GTLRGmail_Message]()

	var labels = [String]()

    var tbview : UITableView? = nil
    let gmailService = GTLRGmailService.init() // initialize mail service
	static let shared = MailManager() // Setting up shared instance of Singleton class

	let realm = RealmService.shared.realm
	var mail: Results<EmailData>?
	
	private init(){ }

	func setMessages(msg : [MailData]){
		print("setMessages() message count = \(msg.count)")
		messages = msg
	}

	func settbView(_tbview : UITableView) {
		self.tbview? = _tbview
	}


	func listLabels(tableview:UITableView) {
		tbview = tableview
		labels.removeAll()
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
					//print(labelList[labelList.endIndex - 1].identifier ?? "")
					labels.append(labelList[labelList.endIndex - 1].identifier! as String)
					//self.messageList.append(response as! GTLRGmail_Message)

				}

			}
			//
		}

		)
		tbview?.reloadData()



	}
	/*
	DESCRIPTION:
	listMessages(tableview)

	Parameters:
	tableview -> UITableView object to add items to
	*/
	func listMessages(tableview :UITableView){
		listMessages(tableview: tableview, folder: mailBox)
//        listMessages(tableview: tableview, folder: mailBox1)
//        listMessages(tableview: tableview, folder: mailBox2)
	}

	/*
	DESCRIPTION:
	listMessages(tableview, folder)

	Parameters:
	tableview -> UITableView object to add items to
	folder -> String with folder to grab items from
	*/
	func listMessages(tableview:UITableView, folder : String) {
		tbview = tableview
		messages.removeAll()
		messageList.removeAll()
		mail = realm.objects(EmailData.self)
		gmailService.shouldFetchNextPages = true
		let listQuery = GTLRGmailQuery_UsersMessagesList.query(withUserId: "me")
		listQuery.labelIds = [folder] // folder to view
		listQuery.maxResults = 50

		// get authorized user
		let authorizer = GIDSignIn.sharedInstance()?.currentUser?.authentication?.fetcherAuthorizer()

		// set mail service authorizer
		gmailService.authorizer = authorizer

		// execute the search of gmail messages
		gmailService.executeQuery(listQuery) { (ticket, response, error) in
			if response != nil {
				self.getFirstMessageIdFromMessages(response: response as! GTLRGmail_ListMessagesResponse)
			} else {
				print("Error: ")
				print(error as Any)
			}

		}
	}

     func dataFilling(_ emailData: EmailData, _ m: MailData) {
		
            emailData.emailSubject = m.subject ?? ""
            emailData.fromSender = m.from ?? ""
            emailData.toRecepiant = m.to ?? ""
            emailData.emailBody = m.body ?? ""
            emailData.emailDate = m.date ?? ""
            emailData.emaiTime = m.time ?? ""
			emailData.messageID = m.messageID ?? ""
            RealmService.shared.create(emailData)
           
         
    }
    
   func dataFactory(_ m: MailData) {
        let emailData = EmailData()
        emailData.mBox = mailBox
//        emailData.mBox1 = mailBox1
//        emailData.mBox2 = mailBox2
        
        
        if (emailData.mBox == "INBOX"){
            
            dataFilling(emailData, m)
            
        } else if (emailData.mBox == "DRAFT"){
            
            dataFilling(emailData, m)
        }else if (emailData.mBox == "SENT" ){
            
            dataFilling(emailData, m)
        }
    }
    
    func getFirstMessageIdFromMessages(response: GTLRGmail_ListMessagesResponse) {
		//print(response.jsonString())
		var from : String = ""
		var to : String = ""
		var date : String = ""
		var subject : String = ""
		var msgtime : String = ""
		var mID : String = ""
		let messagesResponse = response as GTLRGmail_ListMessagesResponse

		messagesResponse.messages?.forEach({ (msg) in
		let query = GTLRGmailQuery_UsersMessagesGet.query(withUserId: "me", identifier: msg.identifier!)
		gmailService.executeQuery(query) { [self] (ticket, response, error) in
			if response != nil {
				self.messageList.append(response as! GTLRGmail_Message)
				do {
					// loops thru each message in list
					try self.messageList.forEach { (message) in
						print(message.jsonString())
						mID = message.identifier! // messageID
						//get header info and the body of the email and decode it
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
						// gets HTML part of message
						guard let message2 = message.payload!.parts?[self.HTMLMessage] else
						{return }
						if (message2.body!.data != nil) {
						let mail = self.base64urlToBase64(base64url: (message2.body!.data!))

						if let data = Data(base64Encoded: mail) {

							let m = MailData(subject: subject, from: from, to: to, body:String(data: data, encoding: .utf8)!, date: date, time: msgtime,  messageID: mID)

							self.messages.append(m)
							checkForDuplicates(data: m)
													}

						} else { return }
					}
				}catch {
					print(error as Any)
				}
				// make sure table view gets loaded with new data
				self.tbview!.reloadData()
			} else {
				print("Error: ")
				print(error as Any)
			}
		}
		})
	}

	/**
		checkForDuplicates(data: MailData)

	Parameters:
	'data'  instance of MailData class to check
	*/

	func checkForDuplicates(data: MailData){
		if mail!.count == 0 {
			//print("adding message")
			self.dataFactory(data)
			return
		}
		//mail?.forEach { (msg) in
		// contains method used to check for duplicates of messageID
			if self.mail!.contains(where: {$0.messageID == data.messageID}) {
			//if msg.messageID == data.messageID {
				//print("Duplicate message \(data.messageID!)")
				return
			} else {
				//print("added message \(data.messageID!)")
				self.dataFactory(data)
			}
	}

	func base64urlToBase64(base64url: String) -> String {
		let base64 = base64url
			.replacingOccurrences(of: "-", with: "+")
			.replacingOccurrences(of: "_", with: "/")
		return base64
	}
}


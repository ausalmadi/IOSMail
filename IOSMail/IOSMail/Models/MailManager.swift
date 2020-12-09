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
   
    var mailBox = "DRAFT"
	var messages = [MailData]() // Messages array
    var messageList = [GTLRGmail_Message]()
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
	
	func listMessages(tableview:UITableView, folder : String) {
		tbview = tableview
		mail = realm.objects(EmailData.self)
		let listQuery = GTLRGmailQuery_UsersMessagesList.query(withUserId: "me")
		listQuery.labelIds = [folder] // folder to view

		// get authorized user
		let authorizer = GIDSignIn.sharedInstance()?.currentUser?.authentication?.fetcherAuthorizer()

		// set mail service authorizer
		gmailService.authorizer = authorizer
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
		//print(emailData.messageID)
		//print(m.messageID)
		//print(emailData.contains { $0.messageID.isSubset(of:m.messageID) })
		if (emailData.messageID.range(of: m.messageID!) != nil){
		//if (m.messageID != emailData.messageID) {
		//if (m.subject != emailData.emailSubject){
            emailData.emailSubject = m.subject ?? ""
            emailData.fromSender = m.from ?? ""
            emailData.toRecepiant = m.to ?? ""
            emailData.emailBody = m.body ?? ""
            emailData.emailDate = m.date ?? ""
            emailData.emaiTime = m.time ?? ""
			emailData.messageID = m.messageID ?? ""
            RealmService.shared.create(emailData)
           
          } else {
          
          }
    }
    
   func dataFactory(_ m: MailData) {
        let emailData = EmailData()
        emailData.mBox = mailBox
        
        
        if (emailData.mBox == "SENT"){
            
            dataFilling(emailData, m)
            
        } else if (emailData.mBox == "INBOX"){
            
            dataFilling(emailData, m)
        }else if (emailData.mBox == "DRAFT" ){
            
            dataFilling(emailData, m)
        }
    }
    
    func getFirstMessageIdFromMessages(response: GTLRGmail_ListMessagesResponse) {
        
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
					try self.messageList.forEach { (message) in
						//print(message.jsonString())
						//print(message.identifier)
						mID = message.identifier!
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
							let make = self.messages.contains {$0.messageID == mID}
							let m = MailData(subject: subject, from: from, to: to, body:String(data: data, encoding: .utf8)!, date: date, time: msgtime,  messageID: mID)
							if make == false{

								self.messages.append(m)
								dataFactory(m)
							} else {
								//self.messages.appe
								//print("message id does not exist")
								//print(m)
								//dataFactory(m)
							}
						}
						} else { return }
					}

				}catch {
					print(error as Any)
				}
				//print("msglist1")
				messages.forEach { (msg ) in

					print("1 -> \(msg.messageID)")
				}
				//print("msglist2")
				mail?.forEach({ (msg2) in
					print("2 -> \(msg2.messageID)")

				})
				//tbview!.reloadData()
				tbview!.reloadInputViews()
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
		return base64
	}
}


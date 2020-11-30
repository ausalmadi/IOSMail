//
//  MailData.swift
//  iosMail
//
//  Created by David Crispin on 2020-11-03.
//

import Foundation
import RealmSwift

struct MailData {
	let subject : String?
	let from : String?
	let to : String?
	let body : String?
	let date : String?
	let time : String?

	func getSubject() -> String?{
		return self.subject!
	}

	func getBody() -> String?{
		return self.body!
	}
}

class EmailData: Object {
    @objc dynamic var messageID: String = ""
    @objc dynamic var mailBox: String? = "" // INBOX, SENT, DRAFT
    @objc dynamic var emailDate: Date?
	@objc dynamic var emailSubject: String = ""
    @objc dynamic var emailBody: String?
    @objc dynamic var emailReply: String?
    @objc dynamic var emailCrUp: Date?
	@objc dynamic var fromSender: String = ""
	@objc dynamic var toRecepiant: String = ""
    @objc dynamic var ccRecepiant: String? = ""
    @objc dynamic var bccRecepiant: String? = ""
	@objc dynamic var sendDate: Date = Date()
    @objc dynamic var emailRead: Bool = false
    @objc dynamic var emailSent: Bool = false
}

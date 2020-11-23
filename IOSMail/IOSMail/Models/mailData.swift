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

	func getSubject() -> String?{
		return self.subject!
	}

	func getBody() -> String?{
		return self.body!
	}
}

class newMailData: Object {
	@objc dynamic var mailSubject: String = ""
	@objc dynamic var fromSender: String = ""
	@objc dynamic var toRecepiant: String = ""
	@objc dynamic var emailBody: String?
	@objc dynamic var emailDate: Date?
	@objc dynamic var sendDate: Date = Date()
}

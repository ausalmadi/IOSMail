//
//  GMailManager.swift
//  iosMail
//
//  Created by David Crispin on 2020-11-09.
//
import Foundation
import GoogleAPIClient

class GMailManager {

	let service = GTLServiceGmail()

	func sendEmail() {

		guard let query = GTLQueryGmail.queryForUsersMessagesSend(with: nil) else {
			return
		}

		let gtlMessage = GTLGmailMessage()
		gtlMessage.raw = self.generateRawString()

		query.message = gtlMessage

		self.service.executeQuery(query, completionHandler: { (ticket, response, error) -> Void in
			print("ticket \(String(describing: ticket))")
			print("response \(String(describing: response))")
			print("error \(String(describing: error))")
		})
	}

	func generateRawString() -> String {

		let dateFormatter:DateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"; //RFC2822-Format
		let todayString:String = dateFormatter.string(from: NSDate() as Date)

		let rawMessage = "" +
			"Date: \(todayString)\r\n" +
			"From: <mail>\r\n" +
			"To: username <mail>\r\n" +
			"Subject: Test send email\r\n\r\n" +
			"Test body"

		print("message \(rawMessage)")

		return GTLEncodeWebSafeBase64(rawMessage.data(using: String.Encoding.utf8))
	}

	func getMail(){
		let query = GTLQueryGmail.queryForUsersMessagesList()
		query!.q = "is_unread"
		service.executeQuery(query!,
							 delegate: self, didFinish: nil)
		//didFinish: #selector(displayResultWithTicket2(ticket:finishedWithObject:error:))
	}
}

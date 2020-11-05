//
//  Messages.swift
//  iosMail
//
//  Created by David Crispin on 2020-11-03.
//

import Foundation

struct Messages {
	let subject : String
	let from : String
	let to : String
	let body : String
	let date : String

	func getSubject() -> String{
		return self.subject
	}
}

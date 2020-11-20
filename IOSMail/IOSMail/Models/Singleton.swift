//
//  Singleton.swift
//  iosMail
//
//  Created by David Crispin on 2020-11-19.
//

import Foundation

class Singleton {

	// MARK: - Properties

	var messages = [MailData]()

	// Initialization

	init(msg : [MailData]) {
		messages = msg

	}

}

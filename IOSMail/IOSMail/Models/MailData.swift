//
//  MailData.swift
//  iosMail
//
//  Created by David Crispin on 2020-11-03.
//

import Foundation

struct MailData {
	var subject : String?
	var from : String?
	var to : String?
	var body : String?
    let date : String?

    func getSubject() -> String?{
        return self.subject!
    }

    func getBody() -> String?{
        return self.body!
    }
}

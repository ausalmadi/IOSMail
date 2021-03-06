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

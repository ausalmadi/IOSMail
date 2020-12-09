//
//  EmailData.swift
//  iosMail
//
//  Created by Aus on 2020-11-30.
//

import Foundation
import RealmSwift

class EmailData: Object {
    @objc dynamic var messageID: String = ""
    @objc dynamic var mBox: String? = "" // INBOX, SENT, DRAFT
    @objc dynamic var emailDate: String? = ""
    @objc dynamic var emaiTime: String? = ""
    @objc dynamic var emailSubject: String = ""
    @objc dynamic var emailBody: String? = ""
    @objc dynamic var emailReply: String?
    @objc dynamic var emailCrUp: Date?
    @objc dynamic var fromSender: String = ""
    @objc dynamic var toRecepiant: String = ""
    @objc dynamic var ccRecepiant: String? = ""
    @objc dynamic var bccRecepiant: String? = ""
    @objc dynamic var sendDate: String? = ""
    @objc dynamic var emailRead: Bool = false
    @objc dynamic var emailSent: Bool = false
}

//
//  Settings.swift
//  iosMail
//
//  Created by Gervan Nantel on 2020-11-18.
//

import Foundation
import RealmSwift

class Settings: Object {
    @objc dynamic var emailReply: String = ""
    @objc dynamic var useSignature: Bool = false
    @objc dynamic var signatureLine: String = ""
    @objc dynamic var dateUpdated: Date?
}

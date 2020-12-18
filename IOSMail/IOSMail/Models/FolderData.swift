//
//  FolderData.swift
//  iosMail
//
//  Created by Gervan Nantel on 2020-12-15.
//


import Foundation
import RealmSwift

class FolderData: Object {
    @objc dynamic var folderID: String = ""
    @objc dynamic var folderLabel: String? = "" // INBOX, SENT, DRAFT
    @objc dynamic var folderCount: Int = 0
    @objc dynamic var folderDisplay: Bool = true
}

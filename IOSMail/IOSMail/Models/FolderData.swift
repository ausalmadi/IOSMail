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
    @objc dynamic var label: String? = "" // INBOX, SENT, DRAFT
    @objc dynamic var labelDisplay: Bool = true
}

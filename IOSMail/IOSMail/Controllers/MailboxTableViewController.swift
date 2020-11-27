//
//  MailboxTableViewController.swift
//  iosMail
//
//  Created by Gervan Nantel on 2020-11-26.
//

import UIKit

class MailboxTableViewController: UITableViewController {
    
    let mailBoxesArray = ["INBOX", "SENT", "DRAFT"]
    var mailBox = "INBOX"

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mailBoxesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mailboxCell", for: indexPath)
        
        cell.textLabel?.text = mailBoxesArray[indexPath.row]
        
        return cell
    }


}

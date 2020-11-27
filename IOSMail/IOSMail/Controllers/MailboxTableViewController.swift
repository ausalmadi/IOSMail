//
//  MailboxTableViewController.swift
//  iosMail
//
//  Created by Gervan Nantel on 2020-11-26.
//

import UIKit

class MailboxTableViewController: UITableViewController {
    
    let mailBoxesArray = ["INBOX", "SENT", "DRAFT"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mailBoxesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mailboxCell", for: indexPath)
        
        cell.textLabel?.text = mailBoxesArray[indexPath.row]
        
        return cell
    }

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(indexPath.row)
		//index = indexPath.row
		performSegue(withIdentifier: "emailDetails", sender: self)
	}

}

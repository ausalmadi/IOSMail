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


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mailBoxesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mailboxCell", for: indexPath)
        
        cell.textLabel?.text = mailBoxesArray[indexPath.row]
        
        return cell
    }
    
    // MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        //index = indexPath.row
        performSegue(withIdentifier: "emailDetails", sender: self)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EmailTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedMailBox = mailBox
        }
    }

}

//
//  MailboxTableViewController.swift
//  iosMail
//
//  Created by Gervan Nantel on 2020-11-26.
//

import UIKit

class MailboxTableViewController: UITableViewController {
    
    var mailBoxesArray = ["INBOX", "SENT", "DRAFT"]
    var mailBox = "INBOX"
	let manager = MailManager.shared
	
	@IBOutlet var labels: UITableView!

	override func viewWillAppear(_ animated: Bool) {
		manager.listLabels(tableview: labels)
	}
	override func viewDidLoad() {
        super.viewDidLoad()

		mailBoxesArray = manager.labels
		labels.reloadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mailBoxesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mailboxCell", for: indexPath)
        
        cell.textLabel?.text = mailBoxesArray[indexPath.row]
        
        return cell
    }
    
    //MARK: - Navigation buttons
    
    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showSettings", sender: self)
    }
    
    // MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
		self.mailBox = mailBoxesArray[indexPath.row]
		manager.mailBox = self.mailBox
        //index = indexPath.row
        performSegue(withIdentifier: "emailDetails", sender: self)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let destinationVC = segue.destination as! EmailTableViewController
		//manager.mailBox = self.mailBox
		//destinationVC.selectedMailBox = mailBox
       /* if let indexPath = tableView.indexPathForSelectedRow {
			manager.mailBox = self.mailBox
			//destinationVC.selectedMailBox = mailBox
        }*/
    }
    
   
    

}

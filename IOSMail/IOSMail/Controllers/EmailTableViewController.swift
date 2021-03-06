//
//  EmailTableViewController.swift
//  iosMail
//
//  Created by Gervan Nantel on 2020-11-27.
//

import UIKit

class EmailTableViewController: UITableViewController {
    
    let emailList = ["Inbox", "Sent", "Draft"]
	var manager = MailManager.shared

	@IBOutlet var tbView: UITableView!

	var selectedMailBox = "INBOX" {
        didSet {
            // load emails based on selected mailBox above - passed from Mailbox table view
        }
    }
        
    override func viewDidLoad() {
		manager.listMessages(tableview: tbView, folder: manager.mailBox)
		super.viewDidLoad()
		print(manager.mailBox)
		self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
		self.tableView.delegate = self
		self.tableView.dataSource = self
		tbView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {

//    title = 
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.manager.messages.count
	}

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
		//if
			let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as? TableViewCell// {
			cell!.tableLabel.text = self.manager.messages[indexPath.row].subject
			cell!.tableDateLabel.text = self.manager.messages[indexPath.row].date
			cell!.tableSubjectLabel.text = self.manager.messages[indexPath.row].body

			//return cell
		//}
		//return UITableViewCell()

        return cell!
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

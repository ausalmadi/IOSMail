//
//  FolderTableViewController.swift
//  iosMail
//
//  Created by Gervan Nantel on 2020-12-15.
//

import UIKit

class FolderTableViewController: UITableViewController {

    var mailBoxesArray = ["INBOX", "SENT", "DRAFT"]
    var mailBox = "INBOX"
    let manager = MailManager.shared

    @IBOutlet var labels: UITableView!

    override func viewWillAppear(_ animated: Bool) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight =  70
		self.labels.register(UINib(nibName: "FolderViewCell", bundle: nil), forCellReuseIdentifier: "folderCell")
		manager.listLabels(tableview: labels)
        labels.reloadData() // Reload tableview data for Labels/Folders
    }


	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		if let firstVC = presentingViewController as? HomeViewController {
			DispatchQueue.main.async {
				firstVC.mailboxText = self.manager.mailBox
				firstVC.viewDidLoad()
			}
		}
	}
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return manager.labels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath) as? FolderViewCell

		cell?.folderDescriptionLabel?.text = manager.labels[indexPath.row]

		return cell!
    }
    
//    //MARK: - Navigation buttons
//    
//    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
//        performSegue(withIdentifier: "showSettings", sender: self)
//    }
//    
    // MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		manager.mailBox = self.manager.labels[indexPath.row]
		dismiss(animated: true, completion: nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let destinationVC = segue.destination as! EmailTableViewController
		//print(segue.destination)
        //manager.mailBox = self.mailBox
        //destinationVC.selectedMailBox = mailBox
       /* if let indexPath = tableView.indexPathForSelectedRow {
            manager.mailBox = self.mailBox
            //destinationVC.selectedMailBox = mailBox
        }*/
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

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
//        mailBoxesArray = manager.messageList
//        manager.messageList(tableView: manager.messageList)
//        labels.reloadData() // Reload tableview data for Labels/Folders
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mailBoxesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath)
        
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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

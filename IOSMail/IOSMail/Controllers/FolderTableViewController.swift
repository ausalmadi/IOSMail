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
        
        tableView.rowHeight =  50
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
    
    //MARK: - Navigation buttons
    
    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showSettings", sender: self)
    }
    
    // MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		manager.mailBox = self.manager.labels[indexPath.row]
		dismiss(animated: true, completion: nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}

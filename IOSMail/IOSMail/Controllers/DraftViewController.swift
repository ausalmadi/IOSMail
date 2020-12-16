//
//  DraftViewController.swift
//  iosMail
//
//  Created by Gervan on 2020-12-04.
//

import UIKit
import RealmSwift

class DraftViewController: MainViewController {

    @IBOutlet weak var tableView: UITableView!
    let manager = MailManager.shared
    var mailboxText : String = "DRAFT"  // Used to set the title of the mailbox, the folder in listMessages & the filter for emails
    let realm = RealmService.shared.realm
    var mail: Results<EmailData>?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        manager.mailBox = mailboxText
        manager.listMessages(tableview: tableView, folder: manager.mailBox)
    }
	
	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

        mail = realm.objects(EmailData.self).filter("mBox == '\(mailboxText)'")

        self.tableView.delegate = self
        self.tableView.dataSource = self
		tableView.reloadData()
    }
}

//MARK: Tableview delegate and datasource

extension DraftViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mail?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if   editingStyle == .delete {
                guard let message = mail?[indexPath.row] else { return  }
                RealmService.shared.delete(message)
            }
        
            tableView.reloadData()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as? TableViewCell
        if let message = mail?[indexPath.row]{
			//if message.mBox == manager.mailBox {
              cell!.tableLabel?.text = message.emailSubject
              cell!.tableDateLabel?.text = message.emailDate
              cell!.tableSubjectLabel?.text = message.emailSnippet
		//}

        }else{
            print("error")
        }
        return cell!
    }
}

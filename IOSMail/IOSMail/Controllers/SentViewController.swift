//
//  SentViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit
import RealmSwift

class SentViewController: MainViewController {

    @IBOutlet weak var tableView: UITableView!
	let manager = MailManager.shared

	let realm = RealmService.shared.realm
	var mail: Results<EmailData>?
    

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
        manager.mailBox = "SENT"
        manager.listMessages(tableview: tableView, folder: manager.mailBox)
//        manager.listMessages(tableview: tableView, folder: manager.mailBox2)
	}
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        mail = realm.objects(EmailData.self).filter("mBox == 'SENT'")
        self.tableView.delegate = self
        self.tableView.dataSource = self
		tableView.reloadData()

    }
}

//MARK: Tableview delegate and datasource

extension SentViewController: UITableViewDelegate, UITableViewDataSource{
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
         
              cell!.tableLabel?.text = message.emailSubject
              cell!.tableDateLabel?.text = message.emailDate
              cell!.tableSubjectLabel?.text = message.emailBody
        }else{
            print("error")
        }
        return cell!
    }
}

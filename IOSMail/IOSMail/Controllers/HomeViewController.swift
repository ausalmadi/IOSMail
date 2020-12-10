//
//  HomeViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit
import GoogleSignIn
import RealmSwift
import GoogleAPIClientForREST

class HomeViewController: UIViewController {
	
	var messages = [MailData]()
	var messageList = [GTLRGmail_Message]()
	var manager = MailManager.shared
    var inboxText : String = "Draft"
    var index : Int = 0
    
    let gmailService = GTLRGmailService.init()

    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var deletePressed: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
  	@IBOutlet var inboxTitle: UILabel!
	  @IBOutlet var inbox: UITableView!
	  @IBOutlet weak var sb: UISearchBar!

    let realm = RealmService.shared.realm
       var mail: Results<EmailData>?

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		manager.listMessages(tableview: tableView, folder: "INBOX") // manager.mailBox)
	}
	override func viewDidLoad() {
		super.viewDidLoad()
        mail = realm.objects(EmailData.self)

        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
		inboxTitle.text = inboxText
		tableView.reloadData()
    }
    
	@IBAction func signout(_ sender: Any) {
		GIDSignIn.sharedInstance()?.signOut()
		GIDSignIn.sharedInstance()?.disconnect()
		if let mvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView") as? MainViewController {
			mvc.modalPresentationStyle = .fullScreen
			self.present(mvc, animated: true, completion: nil)
		}
	}

	deinit {
		NotificationCenter.default.removeObserver(self,
          name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
          object: nil)
    }

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)

		GIDSignIn.sharedInstance().signOut()
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "MainToReader") {
			let vc = segue.destination as! ReadingViewController
			guard let message = mail?[index] else { return  }
			vc.setMessage(msg: message)
		}
		print(segue.identifier as Any)
	}
	
//MARK: Notification method
	@objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
		if notification.name.rawValue == "ToggleAuthUINotification" {
			if notification.userInfo != nil {
                guard (notification.userInfo as? [String:String]) != nil else { return }
			}
		}
	}
}

//MARK: Tableview delegate and datasource


extension HomeViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return mail?.count ?? 0
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
    
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		index = indexPath.row
		performSegue(withIdentifier: "MainToReader", sender: self)
	}

}

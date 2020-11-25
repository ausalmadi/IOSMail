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
	let gmailService = GTLRGmailService.init()
	var messageList = [GTLRGmail_Message]()

	var manager = MailManager.shared

	
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var deletePressed: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
	@IBOutlet var inboxTitle: UILabel!

	var inboxText : String = "Inbox"
	var index : Int = 0
	
	@IBOutlet var inbox: UITableView!
	@IBOutlet weak var sb: UISearchBar!

//	func setMessages(msg : [MailData]){
//		print("setMessages() message count = \(msg.count)")
//		//messages = msg
//
//	}


	override func viewWillAppear(_ animated: Bool) {
		//manager.settbView(_tbview: tableView)

	}
    override func viewDidLoad() {

		super.viewDidLoad()

		manager.listInboxMessages(tableview: tableView, folder: manager.INBOX)

		NotificationCenter.default.addObserver(self,
           selector: #selector(MainViewController.receiveToggleAuthUINotification(_:)),
           name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
           object: nil)

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

			vc.setMessage(msg: self.manager.messages[self.index])
		}
		print(segue.identifier as Any)
	}
	
//MARK: Notification method
	@objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
		if notification.name.rawValue == "ToggleAuthUINotification" {

			if notification.userInfo != nil {
				guard let userInfo = notification.userInfo as? [String:String] else { return }
			}
		}
	}
}

//MARK: Tableview delegate and datasource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.manager.messages.count
    }

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(indexPath.row)
		index = indexPath.row
		performSegue(withIdentifier: "MainToReader", sender: self)
	}

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as? TableViewCell {
			cell.tableLabel.text = self.manager.messages[indexPath.row].subject
			cell.tableDateLabel.text = self.manager.messages[indexPath.row].date
			cell.tableSubjectLabel.text = self.manager.messages[indexPath.row].body

            return cell
        }
        return UITableViewCell()
    }
}

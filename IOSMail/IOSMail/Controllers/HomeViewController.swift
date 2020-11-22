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
	
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var deletePressed: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
	@IBOutlet var inboxTitle: UILabel!

	var messages = [MailData]()
	var inboxText : String = "Inbox"
	var index : Int = 0
	
	@IBOutlet var inbox: UITableView!
	@IBOutlet weak var sb: UISearchBar!

	func setMessages(msg : [MailData]){
		print("setMessages() message count = \(msg.count)")
		//messages = msg
		
	}


	override func viewWillAppear(_ animated: Bool) {
		listInboxMessages()
	}
    override func viewDidLoad() {

		super.viewDidLoad()

		NotificationCenter.default.addObserver(self,
           selector: #selector(MainViewController.receiveToggleAuthUINotification(_:)),
           name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
           object: nil)

        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
		inboxTitle.text = inboxText

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

			vc.setMessage(msg: messages[self.index])
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

//MARK: Getting messages into inbox view controller
	//for test

	func listInboxMessages() {

		let listQuery = GTLRGmailQuery_UsersMessagesList.query(withUserId: "me")
		listQuery.labelIds = ["INBOX"]

		let authorizer = GIDSignIn.sharedInstance()?.currentUser?.authentication?.fetcherAuthorizer()

		gmailService.authorizer = authorizer
	//gmailService.shouldFetchNextPages = true
		listQuery.maxResults = 5

		gmailService.executeQuery(listQuery) { (ticket, response, error) in
	if response != nil {
	self.getFirstMessageIdFromMessages(response: response as! GTLRGmail_ListMessagesResponse)
	} else {
	print("Error: ")
	print(error as Any)
	}
	}
	}

	func getFirstMessageIdFromMessages(response: GTLRGmail_ListMessagesResponse) {
		var from : String = ""
		var to : String = ""
		var date : String = ""
		var subject : String = ""
	let messagesResponse = response as GTLRGmail_ListMessagesResponse
		
		messagesResponse.messages!.forEach({ (msg) in
		let query = GTLRGmailQuery_UsersMessagesGet.query(withUserId: "me", identifier: msg.identifier!)
		gmailService.executeQuery(query) { [self] (ticket, response, error) in

		if response != nil {
			self.messageList.append(response as! GTLRGmail_Message)
		self.messageList.forEach { (message) in
	//get the body of the email and decode it
		message.payload!.headers?.forEach {( head) in

		if head.name=="Date" {
			date = self.base64urlToBase64(base64url: head.value ?? "default value")
		}
		if head.name=="Subject" {
			subject = self.base64urlToBase64(base64url: head.value ?? "default value")
		}
		if head.name=="From" {
			from = self.base64urlToBase64(base64url: head.value ?? "default value")
		}
		if head.name=="To" {
			to = self.base64urlToBase64(base64url: head.value ?? "default value")
		}
	}

	guard let message2 = message.payload!.parts?[0] else
	{return }
	let mail = self.base64urlToBase64(base64url: message2.body!.data!)

	if let data = Data(base64Encoded: mail) {
	  let m = MailData(subject: subject, from: from, to: to, body:String(data: data, encoding: .utf8)!, date: date)
	  self.messages.append(m)
	 }
	}
		tableView.reloadData()
	 } else {
	  print("Error: ")
	  print(error as Any)
	 }
	}

	})

}

func base64urlToBase64(base64url: String) -> String {
	var base64 = base64url
		.replacingOccurrences(of: "-", with: "+")
		.replacingOccurrences(of: "_", with: "/")
	if base64.count % 4 != 0 {
		base64.append(String(repeating: "=", count: 4 - base64.count % 4))
	}
	return base64
	}
}

//MARK: Tableview delegate and datasource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.messages.count
    }

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(indexPath.row)
		index = indexPath.row
		performSegue(withIdentifier: "MainToReader", sender: self)
	}

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as? TableViewCell {
			cell.tableLabel.text = self.messages[indexPath.row].subject
			cell.tableDateLabel.text = self.messages[indexPath.row].date
			cell.tableSubjectLabel.text = self.messages[indexPath.row].body

            return cell
        }
        return UITableViewCell()
    }
}

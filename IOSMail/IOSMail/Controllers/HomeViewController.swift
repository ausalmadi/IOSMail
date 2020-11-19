//
//  HomeViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit
import GoogleSignIn

class HomeViewController: UIViewController {

    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var deletePressed: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
	@IBOutlet var inboxTitle: UILabel!
	
	var messages = [MailData]()
//	var mailManager = MailManager()
	var inboxText : String = "Inbox"

	var index : Int = 0
	
	@IBOutlet var inbox: UITableView!
	@IBOutlet weak var sb: UISearchBar!
    
	//@IBOutlet var textview: UITextView!

    override func viewDidLoad() {

		super.viewDidLoad()
		let newMsg = MailData(subject: "Re: Subject", from: "some@one.com", to: "some@one.else.com", body: "Some more text goes here", date: "Oct 31, 2020")
		messages.append(newMsg)
		let newMsg1 = MailData(subject: "Subject", from: "some@one.com", to: "some@one.else.com", body: "Some text goes here", date: "Oct 30, 2020")

		messages.append(newMsg1)
		NotificationCenter.default.addObserver(self,
           selector: #selector(MainViewController.receiveToggleAuthUINotification(_:)),
           name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
           object: nil)

        // Do any additional setup after loading the view.
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


		print("dismissed homeview")


	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "MainToReader") {
			let vc = segue.destination as! ReadingViewController

			vc.setMessage(msg: messages[self.index])
		}
		print(segue.identifier as Any)
	}
	
	@objc func receiveToggleAuthUINotification(_ notification: NSNotification) {


		if notification.name.rawValue == "ToggleAuthUINotification" {

			if notification.userInfo != nil {
				guard let userInfo = notification.userInfo as? [String:String] else { return }
				inboxTitle.text = userInfo["statusText"]!

			}
		}
	}
}

//MARK: Tableview delegate and datasource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//let selectedTrail = trails[indexPath.row]
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


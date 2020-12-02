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


//	override func viewWillAppear(_ animated: Bool) {
//	}
    let realm = RealmService.shared.realm
       var mail: Results<EmailData>?



    override func viewDidLoad() {

		super.viewDidLoad()
        mail = realm.objects(EmailData.self)
        manager.listInboxMessages(tableview: tableView, folder: manager.mailBox)

//		NotificationCenter.default.addObserver(self,
//           selector: #selector(MainViewController.receiveToggleAuthUINotification(_:)),
//           name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
//           object: nil)

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
	//	return self.manager.messages.count
       return mail?.count ?? 1
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        if let massage = mail?[indexPath.row]{
           // print("\(massage.emailSubject)")
            //cell.textLabel?.text = massage.
//            cell.tableLabel.text = massage.emailSubject
//            cell.tableDateLabel.text = massage.emailDate
//            cell.tableSubjectLabel.text = massage.emailBody
        }else{
            print("error")
        }
        return cell
    }


//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let  cell = tableview.dequeueReusableCell(withIdentifier: "email", for: indexPath)
//            if let massage = mail?[indexPath.row]{
//                cell.textLabel?.text = massage.massege
//            }else{
//                print("no messages ")
//            }
//             return cell
//        }

    
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////		print(indexPath.row)
////		index = indexPath.row
////		performSegue(withIdentifier: "MainToReader", sender: self)
//	}

//    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let  cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//               if let massage = mail?[indexPath.row]{
//                   cell.textLabel?.text = massage.massege
//               }else{
//                   print("no messages ")
//               }
//                return cell
//           }

//        if let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as? TableViewCell {
//            let emailData = EmailData()
//
//            cell.tableLabel.text = emailData.emailSubject
//			cell.tableDateLabel.text = emailData.emailDate
//            cell.tableSubjectLabel.text = emailData.emailBody
//
//            return cell
//        }
//        return UITableViewCell()
}
    

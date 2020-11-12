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
	
	var messages = [Messages]()
	var mailManager = MailManager()
	var inboxText : String = "Inbox"

	var index : Int = 0
	
	@IBOutlet var inbox: UITableView!
	@IBOutlet weak var sb: UISearchBar!
	//FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)
	//let data = ["From: ABC", "From: DFG","From: ROAA","From: 123", "From: CLASS","From: ABC"]
    //let date = ["1 Aug","1 Sep","1 Oct","17 Oct","20 Oct","30 Oct"]
   // let subject = ["Subject: 1", "Subject: 2", "Subject: 3", "Subject: 4", "Subject: 5", "Subject: 6"]
    
	//@IBOutlet var textview: UITextView!

    override func viewDidLoad() {

		super.viewDidLoad()
		let newMsg = Messages(subject: "Re: Subject", from: "some@one.com", to: "some@one.else.com", body: "Some more text goes here", date: "Oct 31, 2020")
		messages.append(newMsg)
		let newMsg1 = Messages(subject: "Subject", from: "some@one.com", to: "some@one.else.com", body: "Some text goes here", date: "Oct 30, 2020")

		messages.append(newMsg1)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(MainViewController.receiveToggleAuthUINotification(_:)),
											   name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
											   object: nil)

        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

		mailManager.delegate = self
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
		//GIDSignIn.sharedInstance().disconnect()
		GIDSignIn.sharedInstance().signOut()

		//dismiss(animated: true, completion: nil)
		print("dismissed homeview")
		// [START_EXCLUDE silent]
		//statusText.text = "Signed out."
		//toggleAuthUI()

	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "MainToReader") {
			let vc = segue.destination as! ReadingViewController

			vc.setMessage(msg: messages[self.index])
		}
		print(segue.identifier as Any)
	}
	
	@objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
		//if notification.name.rawValue == "GetMailNotification" {
		//	print("Getting mail")
		//}

		if notification.name.rawValue == "ToggleAuthUINotification" {
			//self.toggleAuthUI()
			if notification.userInfo != nil {
				guard let userInfo = notification.userInfo as? [String:String] else { return }
				//performSegue(withIdentifier: "HomeView", sender: nil)
				//print("\(userInfo["statusText"]!)?")
				inboxTitle.text = userInfo["statusText"]!

				//self.statusText.text = userInfo["statusText"]!
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
		/*let viewController:
			UIViewController = UIStoryboard(
				name: "Main", bundle: nil
			)
			.instantiateViewController(withIdentifier: "Reader") as UIViewController*/
		// .instantiatViewControllerWithIdentifier() returns AnyObject!
		// this must be downcast to utilize it
		//viewController.modalPresentationStyle = .fullScreen
		//self.present(viewController, animated: false, completion: nil)

		/*if let viewController = storyboard?.instantiateViewController(identifier: "TrailViewController") as? TrailViewController {
			viewController.trail = selectedTrail
			navigationController?.pushViewController(viewController, animated: true)
		}*/
	}


    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as? TableViewCell {
			cell.tableLabel.text = self.messages[indexPath.row].subject
				//self.data[indexPath.row]
			cell.tableDateLabel.text = self.messages[indexPath.row].date
				//self.date[indexPath.row]
			cell.tableSubjectLabel.text = self.messages[indexPath.row].body
				//self.subject[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }

}

extension HomeViewController: MailManagerDelegate {
	func didUpdateMail(_ mailManager: MailManager, mail: MailModel) {
		DispatchQueue.main.async {
			//self.temperatureLabel.text = weather.temperatureString
			//self.conditionImageView.image = UIImage(systemName: weather.conditionName)
			//self.cityLabel.text = weather.cityName
			//self.textview.text = mail.emailAddress
		}
	}

	func didFailWithError(error: Error) {
		print(error)
	}
}

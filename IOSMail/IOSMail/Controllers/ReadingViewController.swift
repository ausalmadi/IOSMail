//
//  ReadingViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit

class ReadingViewController: MainViewController {

	var verificationId : String = ""
	var message = Messages(subject: "", from: "", to: "", body: "", date: "")

	@IBOutlet weak var msgBody: UITextView!
	@IBOutlet weak var msgSubject: UITextField!

	@IBOutlet weak var msgFrom: UITextField!
	func setMessage(msg : Messages){
		self.message = msg
		//print (msg.getBody())
		//print (msg.getSubject() )
		
		//if let _ = msg.body { msgBody.text = msg.body! as String}
		//if let _ = msg.subject  { msgSubject.text = msg.subject! as String }

	}
	override func viewDidLoad() {
        super.viewDidLoad()


		msgBody.text = message.body! as String

		msgSubject.text = message.subject! as String
		msgFrom.text = message.from! as String

		
		//print(self.message)

		// Register the table view cell class and its reuse id

		// (optional) include this line if you want to remove the extra empty cell divider lines
		// self.tableView.tableFooterView = UIView()

		// This view controller itself will provide the delegate methods and row data for the table view.
	
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

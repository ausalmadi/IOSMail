//
//  ReadingViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit

class ReadingViewController: MainViewController {

	var verificationId : String = ""
	var message = MailData(subject: "", from: "", to: "", body: "", date: "")

	@IBOutlet weak var msgBody: UITextView!
	@IBOutlet weak var msgSubject: UITextField!

	@IBOutlet weak var msgFrom: UITextField!
	func setMessage(msg : MailData){
		self.message = msg


	}
	override func viewDidLoad() {
        super.viewDidLoad()


		msgBody.text = message.body! as String

		msgSubject.text = message.subject! as String
		msgFrom.text = message.from! as String

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

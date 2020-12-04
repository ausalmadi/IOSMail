//
//  ReadingViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit

class ReadingViewController: MainViewController {

	var verificationId : String = ""
    var  isForward: Bool = false
    var  isReply: Bool = false
	var message = EmailData()

	@IBOutlet weak var msgBody: UITextView!
	@IBOutlet weak var msgSubject: UITextField!
	@IBOutlet weak var msgFrom: UITextField!
    @IBOutlet weak var msgDate: UITextField!

    @IBAction func ForwardButtonPressed(_ sender: UIBarButtonItem) {
        isForward = true
        self.performSegue(withIdentifier: "ReaderToCompose", sender: self)
    }
    @IBAction func ReplyButtonPressed(_ sender: UIBarButtonItem) {
        isForward = false
        isReply = true
        self.performSegue(withIdentifier: "ReaderToCompose", sender: self)
    }

	func setMessage(msg : EmailData){
		self.message = msg
	}
    
	override func viewDidLoad() {
        super.viewDidLoad()
		msgBody.text = message.emailBody
		msgSubject.text = message.emailSubject
		msgFrom.text = message.fromSender
		msgDate.text = message.emailDate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let vc = segue.destination as! ComposingViewController
		vc.fromReaderEmail = message.fromSender as String
        vc.isForwardButtonPressed = isForward
        vc.isReplyButtonPressed = isReply
        vc.subjectFromReader = message.emailSubject as String
		vc.msgBodyFromReader = message.emailBody! as String

    }
}

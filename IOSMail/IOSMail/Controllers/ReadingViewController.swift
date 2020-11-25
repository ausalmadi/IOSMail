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
    
    @IBAction func ForwardButtonPressed(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "ReaderToCompose", sender: self)
    }
    @IBAction func ReplyButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "ReaderToCompose", sender: self)
    }
    func setMessage(msg : MailData){
		self.message = msg
	}
    
	override func viewDidLoad() {
        super.viewDidLoad()

		msgBody.text = message.body! as String
		msgSubject.text = message.subject! as String
		msgFrom.text = message.from! as String
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! ComposingViewController
        vc.FromReaderEmail = message.from! as String

    }
}

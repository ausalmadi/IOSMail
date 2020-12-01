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
	var message = MailData(subject: "", from: "", to: "", body: "",  date: "", time: "")

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

    func setMessage(msg : MailData){
		self.message = msg
	}
    
	override func viewDidLoad() {
        super.viewDidLoad()

//		let htmlData = NSString(string: message.body!).data(using: String.Encoding.utf16.rawValue)
//
//		let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
//		let attributedString = try! NSAttributedString(data: htmlData!,
//													   options: options,
//													   documentAttributes: nil)
		msgBody.text = message.body! as String
		//msgBody.attributedText = message.body!.htmlAttributedString(size: 18, color: UIColor.red)
		msgSubject.text = message.subject! as String
		msgFrom.text = message.from! as String
        print(message.from! as String)
		msgDate.text = message.date! as String
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! ComposingViewController
        vc.fromReaderEmail = message.from! as String
        vc.isForwardButtonPressed = isForward
        vc.isReplyButtonPressed = isReply
        vc.subjectFromReader = message.subject! as String
        vc.msgBodyFromReader = message.body! as String

    }
}

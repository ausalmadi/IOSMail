//
//  ReadingViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit

class ReadingViewController: MainViewController {

	var verificationId : String = ""
	var message = MailData(subject: "", from: "", to: "", body: "",  date: "")

	@IBOutlet weak var msgBody: UITextView!
	@IBOutlet weak var msgSubject: UITextField!
	@IBOutlet weak var msgFrom: UITextField!
    @IBOutlet weak var msgDate: UITextField!

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
		msgDate.text = message.date! as String
    }
}

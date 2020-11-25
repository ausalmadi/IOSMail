//
//  ReadingViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit

class ReadingViewController: MainViewController {

	var verificationId : String = ""
	var message = MailData(subject: "", from: "", to: "", body: "",  date: "", time: "")

	@IBOutlet weak var msgBody: UITextView!
	@IBOutlet weak var msgSubject: UITextField!
	@IBOutlet weak var msgFrom: UITextField!
    @IBOutlet weak var msgDate: UITextField!

	func setMessage(msg : MailData){
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! ComposingViewController
        vc.FromReaderEmail = message.from! as String

    }
}

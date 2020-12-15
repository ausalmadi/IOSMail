//
//  ReadingViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit
import WebKit

class ReadingViewController: MainViewController {

	var verificationId : String = ""
    var  isForward: Bool = false
    var  isReply: Bool = false
	var message = EmailData()

	@IBOutlet weak var msgBodyHTML: WKWebView!
	@IBOutlet weak var msgBody: UITextView!
	@IBOutlet weak var msgSubject: UITextField!
	@IBOutlet weak var msgFrom: UITextField!
    @IBOutlet weak var msgDate: UITextField!

    @IBAction func ForwardButtonPressed(_ sender: UIBarButtonItem) {
        isForward = true
        isReply = false
        self.performSegue(withIdentifier: "ReaderToCompose", sender: self)
    }
    
    @IBAction func ReplyButtonPressed(_ sender: UIBarButtonItem) {
        isForward = false
        isReply = true
        self.performSegue(withIdentifier: "ReaderToCompose", sender: self)
    }

	func setMessage(msg : EmailData){
		// sets local message from previous View controller
		self.message = msg
	}
    
	override func viewDidLoad() {
        super.viewDidLoad()
        msgBody.attributedText = message.emailBody!.htmlToAttributedString
		msgSubject.text = message.emailSubject
		msgFrom.text = message.fromSender
		//msgBodyHTML.loadHTMLString(message.emailBody!, baseURL: nil)
		//TODO: something seems to be missing this data below, as it keeps crashing app
		//msgDate.text = message.emailDate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let vc = segue.destination as! ComposingViewController
		vc.fromReaderEmail = message.fromSender as String
        vc.isForwardButtonPressed = isForward
        vc.isReplyButtonPressed = isReply
        vc.subjectFromReader = (message.emailSubject ?? "") as String
        vc.msgBodyFromReader = "<br><br><br><div style='color:gray'><p>Original email:</p>\(message.emailBody! as String)</div>"
    }

}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

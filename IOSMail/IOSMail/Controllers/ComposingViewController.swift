//
//  ComposingViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit
import GoogleAPIClientForREST
import GoogleSignIn
import GTMSessionFetcher

class ComposingViewController: MainViewController, UITextViewDelegate {
    
    @IBOutlet var toField: UITextField!
    @IBOutlet var ccField: UITextField!
    @IBOutlet var bccField: UITextField!
    @IBOutlet var subjectField: UITextField!
    @IBOutlet var bodyField: UITextView!
    
    var isForwardButtonPressed: Bool = false
    var isReplyButtonPressed: Bool = false
    var fromReaderEmail = ""
    var subjectFromReader = ""
    var msgBodyFromReader = ""
    var sendButtonPressed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyField.delegate = self
        bodyField.textColor = UIColor.black
        if isReplyButtonPressed {
            toField.text = fromReaderEmail
            subjectField.text = "Re: " + subjectFromReader
            bodyField.attributedText = msgBodyFromReader.htmlToAttributedString
        } else if isForwardButtonPressed {
            subjectField.text = "FWD: " + subjectFromReader
            bodyField.attributedText = msgBodyFromReader.htmlToAttributedString
        } else {
            addHint()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if !sendButtonPressed {
            saveDraft()
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        sendEmail()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            if !isReplyButtonPressed && !isForwardButtonPressed {
                textView.text = nil
            }
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            addHint()
        }
    }
    
    func addHint() {
        bodyField.text = "Type here..."
        bodyField.textColor = UIColor.lightGray
    }
    
    func saveDraft() {
        let service = GTLRGmailService()
        let gtlDraft = GTLRGmail_Draft()
        let message = GTLRGmail_Message()
        message.raw = self.generateRawString()
        gtlDraft.message = message
        let query =
            GTLRGmailQuery_UsersDraftsCreate.query(withObject: gtlDraft, userId: "me", uploadParameters: nil)
        let authorizer = GIDSignIn.sharedInstance()?.currentUser?.authentication?.fetcherAuthorizer()
        
        service.authorizer = authorizer
        service.executeQuery(query, completionHandler: { (ticket, response, error) -> Void in
            print("error: \(String(describing: error))")
        })
    }
    
    func sendEmail() {
        sendButtonPressed = true
        let service = GTLRGmailService()
        let gtlMessage = GTLRGmail_Message()
        gtlMessage.raw = self.generateRawString()
        let query =
            GTLRGmailQuery_UsersMessagesSend.query(withObject: gtlMessage, userId: "me", uploadParameters: nil)
        let authorizer = GIDSignIn.sharedInstance()?.currentUser?.authentication?.fetcherAuthorizer()
        
        service.authorizer = authorizer
        service.executeQuery(query, completionHandler: { (ticket, response, error) -> Void in
            let alert = UIAlertController(title: "", message: "Message has been sent successfuly.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
        })
    }
    
    func generateRawString() -> String {
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"; //RFC2822-Format
        let todayString:String = dateFormatter.string(from: NSDate() as Date)
        let rawMessage = "" +
            "Date: \(todayString)\r\n" +
            "From: <>\r\n" +
            "To: \(toField.text ?? "")\r\n" +
            "Subject: \(subjectField.text ?? "")\r\n\r\n" +
            "\(bodyField.text ?? "")"
        _ = rawMessage.data(using: .utf8)
        let utf8Data = rawMessage.data
        let base64EncodedString = utf8Data.base64EncodedString()
        
        return base64EncodedString
    }
}

extension String {
    var data: Data { Data(utf8) }
    var base64Encoded: Data { data.base64EncodedData() }
    var base64Decoded: Data? { Data(base64Encoded: self) }

}

extension Data {
    var base64Decoded: Data? { Data(base64Encoded: self) }
    var string: String? { String(data: self, encoding: .utf8) }
}


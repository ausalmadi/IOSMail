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
    
    
    var FromReaderEmail = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyField.delegate = self
        addHint()
        print(FromReaderEmail)
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
        sendEmail()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
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
    
    func sendEmail() {
        let service = GTLRGmailService()
        let gtlMessage = GTLRGmail_Message()
        gtlMessage.raw = self.generateRawString()
        let query =
            GTLRGmailQuery_UsersMessagesSend.query(withObject: gtlMessage, userId: "me", uploadParameters: nil)
        let authorizer = GIDSignIn.sharedInstance()?.currentUser?.authentication?.fetcherAuthorizer()
        
        
        service.authorizer = authorizer
        service.executeQuery(query, completionHandler: { (ticket, response, error) -> Void in
            print("ticket \(String(describing: ticket))")
            print("response \(String(describing: response))")
            print("error \(String(describing: error))")
        })
    }

    func generateRawString() -> String {

        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"; //RFC2822-Format
        let todayString:String = dateFormatter.string(from: NSDate() as Date)
        let rawMessage = "" +
            "Date: \(todayString)\r\n" +
            "From: <>\r\n" +
            "To: username <\(toField.text ?? "")>\r\n" +
            "Subject: \(subjectField.text ?? "")\r\n\r\n" +
            "\(bodyField.text ?? "")"
        //let utf8str = rawMessage.data(using: .utf8)
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

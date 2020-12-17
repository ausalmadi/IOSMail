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
import MessageUI

class ComposingViewController: MainViewController,
UITextViewDelegate, MFMailComposeViewControllerDelegate {
    
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
            
//           guard let filePath = Bundle.main.path(forResource: "images.jpg", ofType: "jpg") else {
//               return
//           }
//           let url = URL(fileURLWithPath: filePath)
//
//           do {
//           let attachmentData = try Data(contentsOf: url)
//               mailComposer.addAttachmentData(attachmentData, mimeType: "application/jpg", fileName: "images.jpg")
//               mailComposer.mailComposeDelegate = self
//               self.present(mailComposer, animated: true
//                   , completion: nil)
//           } catch let error {
//               print("We have encountered error \(error.localizedDescription)")
//           }
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
//        sendEmail()
        sendWithMailComposer()
    }
    
//    func attachmentData(_ attachment: Data,
//                           mimeType: String,
//                           fileName filename: String) {
//    }
    
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
        gtlMessage.payload?.filename = ""
        let query =
            GTLRGmailQuery_UsersMessagesSend.query(withObject: gtlMessage, userId: "me", uploadParameters: nil)
        let authorizer = GIDSignIn.sharedInstance()?.currentUser?.authentication?.fetcherAuthorizer()
        
        service.authorizer = authorizer
        service.executeQuery(query, completionHandler: { (ticket, response, error) -> Void in
            var status = ""
            var title = ""
            if(error == nil) {
                status = "Message has been sent."
                title = "Successful!"
            } else {
                status = "Message has not been sent."
                title = "Failed!"
            }
            let alert = UIAlertController(title: title, message: status, preferredStyle: .alert)
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
    
    func sendWithMailComposer() {
        if MFMailComposeViewController.canSendMail() {
                    let mailComposer = MFMailComposeViewController()
                    mailComposer.setSubject("Update about ios tutorials")
                    mailComposer.setMessageBody("What is the update about ios tutorials on youtube", isHTML: false)
                    mailComposer.setToRecipients(["fazeli.mojtaba@gmail.com"])
                    guard let filePath = Bundle.main.path(forResource: "./Supporting Files/images", ofType: "jpg") else {
                        return
                    }
                    let url = URL(fileURLWithPath: filePath)
                    
                    do {
                    let attachmentData = try Data(contentsOf: url)
                        mailComposer.addAttachmentData(attachmentData, mimeType: "application/jpg", fileName: "iamges")
                        mailComposer.mailComposeDelegate = self
                        self.present(mailComposer, animated: true
                            , completion: nil)
                    } catch let error {
                        print("We have encountered error \(error.localizedDescription)")
                    }
 
                } else {
                    print("Email is not configured in settings app or we are not able to send an email")
                }
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


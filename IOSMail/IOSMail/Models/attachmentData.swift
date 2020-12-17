//
//  attachmentData.swift
//  iosMail
//
//  Created by student on 2020-12-16.
//

//import Foundation
//import RealmSwift
//import UIKit
//import MessageUI
//
//class attachmentData: MainViewController, MFMailComposeViewControllerDelegate {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//}
//
//    
//    if MFMailComposeViewController() {
//                let mailComposer = MFMailComposeViewController()
//                
//                mailComposer.setToRecipients([""])
//                guard let filePath = Bundle.main.path(forResource: "SimplePDF", ofType: "pdf") else {
//                    return
//                }
//    let url = URL(fileURLWithPath: filePath)
//                
//                do {
//                let attachmentData = try Data(contentsOf: url)
//                    mailComposer.addAttachmentData(attachmentData, mimeType: "application/pdf", fileName: "images")
//                    mailComposer.mailComposeDelegate = self
//                    self.present(mailComposer, animated: true
//                        , completion: nil)
//                } catch let error {
//                    print("We have encountered error \(error.localizedDescription)")
//                }
//    } else {
//              print("Email is not configured in settings app or we are not able to send an email")
//          }
//}
//
//
//      

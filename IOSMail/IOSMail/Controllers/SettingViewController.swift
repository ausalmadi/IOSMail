//
//  SettingViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit
import RealmSwift

class SettingViewController: MainViewController {
    
//    let realm = try! Realm()
    var settings = Settings()

    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var signatureTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailAddress.text = settings.emailReply
        signatureTextView.text = settings.signatureLine

        
    }
    
    @IBAction func signatureOn(_ sender: UISwitch) {
//        UISwitch.init()
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        settings.emailReply = emailAddress.text!
        settings.signatureLine = signatureTextView.text!
        

        }
        
    
    
}

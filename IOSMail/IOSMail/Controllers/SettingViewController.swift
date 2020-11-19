//
//  SettingViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit
import SwiftUI
import RealmSwift

class SettingViewController: MainViewController {
    
    let realm = RealmService.shared.realm
    var settings: Results<Settings>?
    

    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var signatureTextView: UITextView!
    @IBOutlet weak var stateSwitch: UISwitch!
    @IBOutlet weak var addSigLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        settings = realm.objects(Settings.self)
        print(Settings)
        
        
     
        
    }
    
    @IBAction func signatureOn(_ sender: UISwitch) {
        
        if stateSwitch.isOn {
            addSigLabel.text = "Add Signature to eMail"
            stateSwitch.setOn(true, animated:true)

        } else {
            addSigLabel.text = "Don't Add Signature to Email"
            stateSwitch.setOn(false, animated:true)

        }
        
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        let newSettings = Settings()
        newSettings.emailReply = emailAddress.text!
        newSettings.dateUpdated = Date()
        newSettings.signatureLine = signatureTextView.text!
        newSettings.useSignature = stateSwitch.isOn
        
        RealmService.shared.create(newSettings)
        
        dismiss(animated: true, completion: nil)
        }

}

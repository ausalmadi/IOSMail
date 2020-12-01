//
//  SettingViewController.swift
//  iosMail
//
//  Created by Gervan on 2020-10-27.
//

import UIKit
import SwiftUI
import RealmSwift

class SettingViewController: MainViewController {
    
    let realm = RealmService.shared.realm
    var settings: Results<Settings>?
    var noOfEmails: Int = 1
    
    
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var signatureTextView: UITextView!
    @IBOutlet weak var stateSwitch: UISwitch!
    @IBOutlet weak var addSigLabel: UILabel!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var emailStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepperLabel.text! = "0"
        loadSettings()
        signatureOn(stateSwitch)

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
        createSettings()
        dismiss(animated: true, completion: nil)
        }
    
    @IBAction func stepperCount(_ sender: UIStepper) {
        stepperLabel.text = String(format: "%.0f", sender.value)
        noOfEmails = Int(sender.value)
    }
    
    
    //MARK: - Setting functions & options
    
    func createSettings() {
        let newSettings = Settings()
        newSettings.emailReply = emailAddress.text!
        newSettings.signatureLine = signatureTextView.text!
        newSettings.useSignature = stateSwitch.isOn
        newSettings.emailCount = Int(stepperLabel.text!) ?? 1

        RealmService.shared.create(newSettings)

    }
    
    func updateSettings(){
    }
    
    func loadSettings() {
        
        settings = realm.objects(Settings.self)
        settings = settings?.sorted(byKeyPath: "dateUpdated", ascending: false)
        
        let loadSet = settings
        emailAddress.text! = loadSet?.first?.emailReply.self ?? ""
        signatureTextView.text! = loadSet?.first?.signatureLine.self ?? ""
        stateSwitch.isOn = loadSet?.first?.useSignature.self ?? false
        let step = loadSet?.first?.emailCount.self
        stepperLabel.text! = String(step!)
        print(loadSet!)
    }
    
    func deleteSettings() {
        let oldSettings = Settings()
        RealmService.shared.delete(oldSettings)
    }
}

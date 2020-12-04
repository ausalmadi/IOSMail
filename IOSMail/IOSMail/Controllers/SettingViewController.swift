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
    
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var signatureTextView: UITextView!
    @IBOutlet weak var stateSwitch: UISwitch!
    @IBOutlet weak var addSigLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSettings()
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
    
    //MARK: - Setting functions & options
    
    func createSettings() {
        let newSettings = Settings()
        newSettings.emailReply = emailAddress.text!
        newSettings.dateUpdated = Date()
        newSettings.signatureLine = signatureTextView.text!
        newSettings.useSignature = stateSwitch.isOn

        RealmService.shared.create(newSettings)
    }
    
    func updateSettings(){
    }
    
    func loadSettings() {
        settings = realm.objects(Settings.self)
        settings = settings?.sorted(byKeyPath: "dateUpdated", ascending: true)
        let loadSet = Settings()
        emailAddress.text! = loadSet.emailReply.self
        signatureTextView.text! = loadSet.signatureLine.self
        stateSwitch.isOn = loadSet.useSignature.self
        print(loadSet)
    }
    
    func deleteSettings() {
        let oldSettings = Settings()
        RealmService.shared.delete(oldSettings)
    }
}

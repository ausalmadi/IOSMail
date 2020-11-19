//
//  SettingViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit
import RealmSwift

class SettingViewController: MainViewController {
    
    let realm = try! Realm()
    var settings = Results<Settings>?.self

    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var signatureTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func signatureOn(_ sender: UISwitch) {
//        UISwitch.init()
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
    }
    
}

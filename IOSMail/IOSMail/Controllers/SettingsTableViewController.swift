//
//  SettingsTableViewController.swift
//  iosMail
//
//  Created by Gervan Nantel on 2020-11-25.
//

import UIKit
import SwiftUI
import RealmSwift

class SettingsTableViewController: UITableViewController {

    let realm = RealmService.shared.realm
    var settings: Results<Settings>?
    var noOfEmails: Int = 1
    
    @IBOutlet weak var signedInAs: UILabel!
    @IBOutlet weak var signedInEmail: UILabel!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var emailStepper: UIStepper!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var stateSwitch: UISwitch!
    @IBOutlet weak var addSigLabel: UILabel!
    @IBOutlet weak var signatureTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableView.numberOfSections
    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 
//    }
    
    
    //MARK: - Setting functions & options
    
    func createSettings() {
        let newSettings = Settings()
        newSettings.emailReply = emailAddress.text!
        newSettings.dateUpdated = Date()
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


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



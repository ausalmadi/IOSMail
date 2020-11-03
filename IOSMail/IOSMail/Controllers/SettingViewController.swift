//
//  SettingViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit

class SettingViewController: MainViewController {

    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var signatureText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signatureOn(_ sender: UISwitch) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

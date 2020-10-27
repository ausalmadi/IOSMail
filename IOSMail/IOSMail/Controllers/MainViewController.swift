//
//  ViewController.swift
//  IOSMail
//
//  Created by student on 2020-10-19.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

   
    @IBAction func goButon(_ sender: UIButton) {
        performSegue(withIdentifier:"goToMain", sender: self)
    }
    
}


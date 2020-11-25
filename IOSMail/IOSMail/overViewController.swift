//
//  ovewViewController.swift
//  IOSMail
//
//  Created by David Crispin on 2020-10-26.
//

import UIKit

class OverViewController: UIViewController {
	
	@IBAction func readerButton(_ sender: Any) {
		print("reader button pressed")
		//_ = UIStoryboard(name: "readerView", bundle: nil).instantiateViewController(withIdentifier: "readerViewController") as UIViewController?

	}
	
	@IBAction func settingsButton(_ sender: Any) {
		print("settings button pressed")
		//_ = UIStoryboard(name: "readerView", bundle: nil).instantiateViewController(withIdentifier: "readerViewController") as UIViewController?

	}
	override func viewDidLoad() {
		super.viewDidLoad()
		print("loaded second storyboard")
		// Do any additional setup after loading the view.
	}


}

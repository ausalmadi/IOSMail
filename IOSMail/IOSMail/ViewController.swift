//
//  ViewController.swift
//  IOSMail
//
//  Created by student on 2020-10-19.
//

import UIKit

class ViewController: UIViewController {
	
	@IBAction func homeButton(_ sender: Any) 
	{
		let storyboard = UIStoryboard(name: "overView", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: "overViewController")// as! OverViewController
		//self.performSegue(withIdentifier: "overView", sender: self)
		//_let vc = UIStoryboard(name: "overView", bundle: nil)
			//storyboard.instantiateViewController(withIdentifier: "overViewController") //as! OverViewController
		//self.navigationController?.pushViewController(vc, animated: true)
		self.present(vc, animated: true, completion: nil)

	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


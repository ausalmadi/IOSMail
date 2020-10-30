//
//  ReadingViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit

class ReadingViewController: MainViewController, UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.animals.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// create a new cell if needed or reuse an old one
		let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!

		// set the text from the data model
		cell.textLabel?.text = self.animals[indexPath.row]

		return cell
	}

	// method to run when table view cell is tapped
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("You tapped cell number \(indexPath.row).")
	}

	let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]

	// cell reuse id (cells that scroll out of view can be reused)
	let cellReuseIdentifier = "cell"


	@IBOutlet weak var tableView: UITableView!

	override func viewDidLoad() {
        super.viewDidLoad()
		// Register the table view cell class and its reuse id
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
		// (optional) include this line if you want to remove the extra empty cell divider lines
		// self.tableView.tableFooterView = UIView()

		// This view controller itself will provide the delegate methods and row data for the table view.
		tableView.delegate = self
		tableView.dataSource = self

        // Do any additional setup after loading the view.
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
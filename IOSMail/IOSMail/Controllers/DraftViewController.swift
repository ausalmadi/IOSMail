//
//  SentViewController.swift
//  iosMail
//
//  Created by Gervan on 2020-12-04.
//

import UIKit
import RealmSwift

class DraftViewController: MainViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let data = ["To: abc@123.com"]
    let date = ["Dec 1, 2020"]
    let subject = ["Subject: Draft Folder"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
}

//MARK: Tableview delegate and datasource

extension DraftViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as? TableViewCell {
            cell.tableLabel.text = self.data[indexPath.row]
            cell.tableDateLabel.text = self.date[indexPath.row]
            cell.tableSubjectLabel.text = self.subject[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

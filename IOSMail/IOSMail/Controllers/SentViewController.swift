//
//  SentViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit

class SentViewController: MainViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let data = ["To: ABC", "To: CDF","To: GBHDG","To: ABC", "To: CDF","To: GBHDG"]
    let date = ["1 Aug","12 Aug","16 Aug","17 Aug","20 Aug","1 Sep"]
    let lineOne = ["Subject: This is the 1st line", "Subject: Happy Holidays!", "Subject: Have I got something for you", "Subject: This is the best email program ever!", "Subject: What's Up ?", "Subject: Christmas is coming ..."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
}

//MARK: Tableview delegate and datasource

extension SentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as? TableViewCell {
            cell.tableLabel.text = self.data[indexPath.row]
            cell.tableDateLabel.text = self.date[indexPath.row]
            cell.tableLineLabel.text = self.lineOne[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }

}

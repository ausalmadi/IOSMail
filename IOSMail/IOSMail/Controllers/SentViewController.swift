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
    let date = ["Aug 1, 2020","Aug 12, 2020","Aug 16, 2020","Aug 17, 2020","Aug 20, 2020","Sep 1, 2020"]
    let subject = ["Subject: A", "Subject: B", "Subject: C", "Subject: D", "Subject: E", "Subject: F"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
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

//MARK: Tableview delegate and datasource

extension SentViewController: UITableViewDelegate, UITableViewDataSource{
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

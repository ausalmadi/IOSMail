//
//  HomeViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit

class HomeViewController: MainViewController {
  
    
  
    
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var deletePressed: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let data = ["From: ABC", "From: DFG","From: ROAA","From: 123", "From: CLASS","From: ABC"]
    let date = ["1 Aug","1 Sep","1 Oct","17 Oct","20 Oct","30 Oct"]
    let lineOne = ["This is the 1st line", "Happy Holidays!", "Have I got something for you", "This is the best email program ever!", "What's Up ?", "Christmas is coming ..."]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
    }
    
}

//MARK: Tableview delegate and datasource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as? TableViewCell {
            cell.tableLabel.text = self.data[indexPath.row]
            cell.tableDateLabel.text = self.date[indexPath.row]
            cell.tableLineLabel.text = self.lineOne[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }

}

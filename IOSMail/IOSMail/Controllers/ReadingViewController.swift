//
//  ReadingViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit
import RealmSwift

class ReadingViewController: MainViewController {
    @IBOutlet weak var tableview: UITableView!
    let realm = RealmService.shared.realm
    var msg: Results<TMessges>?
    override func viewDidLoad() {
        super.viewDidLoad()
         msg = realm.objects(TMessges.self)
        tableview.delegate = self
        tableview.dataSource = self
    }

    @IBAction func addMessages(_ sender: UIButton) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Message", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Message", style: .default) { (action) in
            
            
                let newMessage = TMessges()
                newMessage.massege = textField.text!
            
            
                RealmService.shared.create(newMessage)
            
            self.tableview.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Message"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

extension ReadingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if   editingStyle == .delete {
            guard let message = msg?[indexPath.row] else { return  }
            RealmService.shared.delete(message)
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
   

}


extension ReadingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msg?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableview.dequeueReusableCell(withIdentifier: "email", for: indexPath)
        if let massage = msg?[indexPath.row]{
            cell.textLabel?.text = massage.massege
        }else{
            print("no messages ")
        }
         return cell
    }
}


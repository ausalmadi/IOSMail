//
//  TableViewCell.swift
//  iosMail
//
//  Created by student on 2020-10-28.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tableLabel: UILabel!
   
    @IBOutlet weak var tableDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

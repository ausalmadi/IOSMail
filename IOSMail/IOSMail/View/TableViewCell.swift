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
    @IBOutlet weak var tableSubjectLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

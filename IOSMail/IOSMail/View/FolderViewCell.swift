//
//  FolderViewCell.swift
//  iosMail
//
//  Created by Gervan Nantel on 2020-12-15.
//

import UIKit

class FolderViewCell: UITableViewCell {

    @IBOutlet weak var folderImage: UIImageView!
    @IBOutlet weak var folderDescriptionLabel: UILabel!
    @IBOutlet weak var folderCountLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

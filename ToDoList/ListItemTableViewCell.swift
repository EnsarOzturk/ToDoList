//
//  ListItemTableViewCell.swift
//  ToDoList
//
//  Created by Ensar on 1.03.2024.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

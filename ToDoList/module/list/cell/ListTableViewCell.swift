//
//  ListTableViewCell.swift
//  ToDoList
//
//  Created by Ensar on 2.07.2024.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet var label: UILabel!
    static let identifier = "ListTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.numberOfLines = 0

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

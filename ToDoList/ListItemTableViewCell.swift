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
        
        label.numberOfLines = 0 // Birden fazla satırı destekle
               label.lineBreakMode = .byWordWrapping // Kelimeleri sarma
               label.adjustsFontSizeToFitWidth = false // Yazı boyutunu uygun hale getirme
               label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  ListCollectionViewCell.swift
//  ToDoList
//
//  Created by Ensar on 4.07.2024.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        setupLabelConstraints()
    }
    
    private func setupLabelConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
        }
    
    func configure(with text: String) {
        label.text = text
        }
    
    required init?(coder: NSCoder) {
        fatalError("error")
        }
    
    //awakeFromNib çalışma konusu
    override func awakeFromNib() {
        super.awakeFromNib()
        print("cell")
    }
}

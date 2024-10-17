//
//  ListCell.swift
//  ToDoList
//
//  Created by Ensar on 19.08.2024.
//

import UIKit

final class ListCell: UICollectionViewCell {
    
    var indexPath: IndexPath?
    
    struct Constant {
        static let labelSystemFont: Double = 15
        static let buttonSystemFont: Double = 20
        static let zero: Double = 0
        static let buttonBorderWidth: Double = 0.5
        static let buttonRadius: Double = 2.5
        static let selected: String = "✓"
        static let normal: String = ""
        static let key: String = "toDoItemsKey"
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = Int(Constant.zero)
        label.font = UIFont.systemFont(ofSize: Constant.labelSystemFont)
        return label
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(Constant.selected, for: .selected)
        button.setTitle(Constant.normal, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constant.buttonSystemFont)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = Constant.buttonBorderWidth
        button.layer.cornerRadius = Constant.buttonRadius
        button.layer.borderColor = UIColor.systemGray2.cgColor
        return button
    }()
    
    private let userDefaultsAssistant = UserDefaultsAssistant<ToDoItem>()
    
    var isChecked: Bool = false {
        didSet {
            checkButton.isSelected = isChecked
            saveToUserDefaults()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.addSubview(checkButton)
        setupConstraints()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            checkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.widthAnchor.constraint(equalToConstant: 25),
            checkButton.heightAnchor.constraint(equalToConstant: 25),
            
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8)
            ])
        }
    
    private func setupButton() {
        checkButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
        
    @objc private func buttonTapped() {
        isChecked.toggle()
        saveToUserDefaults()
    }
    
    private func saveToUserDefaults() {
        guard let indexPath = indexPath else { return }
        var items = userDefaultsAssistant.loadData(forKey: Constant.key)
        
        if items.indices.contains(indexPath.row) {
            items[indexPath.row].isChecked = isChecked
            userDefaultsAssistant.saveData(items, forKey: Constant.key)
        }
    }
       
    func configure(with text: String, isChecked: Bool, indexPath: IndexPath) {
        label.text = text
        self.isChecked = isChecked
        self.indexPath = indexPath
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
        indexPath = nil
    }
}


//
//  String+Extension.swift
//  ToDoList
//
//  Created by Ensar on 9.07.2024.
//

import Foundation
import UIKit

extension String {
    func height(constraintedWidth width: CGFloat, font: UIFont) -> Double {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font // içerde
        label.sizeToFit()
        
        return label.frame.height
    }
}

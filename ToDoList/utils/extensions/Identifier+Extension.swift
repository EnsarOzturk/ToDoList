//
//  Identifier+Extension.swift
//  ToDoList
//
//  Created by Ensar on 11.07.2024.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        String(describing: self)
    }
}

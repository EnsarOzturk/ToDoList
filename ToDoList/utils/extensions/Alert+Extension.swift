//
//  Alert+Extension.swift
//  ToDoList
//
//  Created by Ensar on 5.07.2024.
//

import Foundation
import UIKit

extension UIAlertController {
        func alert(title: String = "", message: String, actionTitle: String, actionHandler: @escaping () -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { action in
                actionHandler()
            }
        alertController.addAction(action)
       
        return alertController
    }
}

//
//  Storyboard+Extension.swift
//  ToDoList
//
//  Created by Ensar on 11.07.2024.
//

import Foundation
import UIKit

extension UIStoryboard {

    func instantiateViewController<T>(ofType type: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: type)
        guard let viewController = instantiateViewController(withIdentifier: identifier) as? T else {
            preconditionFailure("Expected view controller with identifier \(identifier) to be of type \(type)")
        }
        return viewController
    }

    func instantiateInitialViewController<T>(ofType type: T.Type) -> T {
        guard let viewController = instantiateInitialViewController() as? T else {
            preconditionFailure("Expected initial view controller to be of type \(type)")
        }
        return viewController
    }
}

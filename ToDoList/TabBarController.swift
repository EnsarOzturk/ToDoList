//
//  TabBarController.swift
//  ToDoList
//
//  Created by Ensar on 4.07.2024.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initiateTabbarViewControllers()
    }
    
    private func initiateTabbarViewControllers() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let listViewController = storyBoard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        let listNavigation = UINavigationController(rootViewController: listViewController)
        listNavigation.tabBarItem = UITabBarItem(title: "list", image: UIImage(systemName: "list.bullet.circle"), tag: 0)

        let notesViewController = storyBoard.instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
        let notesNavigation = UINavigationController(rootViewController: notesViewController)
        notesNavigation.tabBarItem = UITabBarItem(title: "notes", image: UIImage(systemName: "plus.circle"), tag: 1)
                
        let userViewController = storyBoard.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
        let userNavigation = UINavigationController(rootViewController: userViewController)
        userNavigation.tabBarItem = UITabBarItem(title: "user", image: UIImage(systemName: "person.circle"), tag: 2)
        
        viewControllers = [listNavigation, notesNavigation, userNavigation]
    }
}

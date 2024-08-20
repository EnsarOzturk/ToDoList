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
        let tabbarItems: [(viewControllerType: UIViewController.Type, title: String, imageName: String, tag: Int)] = [
            (ListViewController.self, "list", "list.bullet.circle", 0),
            (NotesViewController.self, "notes", "plus.circle", 1),
            (UserViewController.self, "user", "person.circle", 2),
            (MovieListViewController.self, "movie", "popcorn.circle", 3)
        ]
        
        var viewControllers: [UIViewController] = []
        
        for tabbarItems in tabbarItems {
            let viewController = storyBoard.instantiateViewController(ofType: tabbarItems.viewControllerType)
            
            if let listVC = viewController as? ListViewController {
                let listViewModel = ListViewModel(view: listVC, delegate: listVC, userDefaultsKey: "yourUserDefaultsKey")
                listVC.viewModel = listViewModel
            }
           
            let navigationController = UINavigationController(rootViewController: viewController)
                navigationController.tabBarItem = UITabBarItem(title: tabbarItems.title, image: UIImage(systemName: tabbarItems.imageName), tag: tabbarItems.tag)
                viewControllers.append(navigationController)
        }
            self.viewControllers = viewControllers
    }
}


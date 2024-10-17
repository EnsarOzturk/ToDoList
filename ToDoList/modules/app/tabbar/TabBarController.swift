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
            (MovieListViewController.self, "movie", "popcorn.circle", 2)
        ]
        
        var viewControllers: [UIViewController] = []
        
        for tabbarItem in tabbarItems {
            let viewController = storyBoard.instantiateViewController(ofType: tabbarItem.viewControllerType)
            
            if let listVC = viewController as? ListViewController {
                let listViewModel = ListViewModel(view: listVC, delegate: listVC)
                listVC.viewModel = listViewModel
            }
           
            let navigationController = UINavigationController(rootViewController: viewController)
                navigationController.tabBarItem = UITabBarItem(title: tabbarItem.title, image: UIImage(systemName: tabbarItem.imageName), tag: tabbarItem.tag)
                viewControllers.append(navigationController)
        }
            self.viewControllers = viewControllers
    }
}


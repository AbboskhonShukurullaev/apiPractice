//
//  HomeViewController.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import UIKit

protocol IHomeView: AnyObject {
    var presenter: IHomePresenter? { get set }
    
    func getViewControllers() -> [UIViewController]
    func display(_ viewController: [UIViewController])
}

class HomeViewController: UITabBarController {
    var presenter: IHomePresenter?
    
    override func loadView() {
        super.loadView()
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        tabBar.tintColor = .green
        tabBar.unselectedItemTintColor = .systemGray
    }
}

extension HomeViewController: IHomeView {
    func getViewControllers() -> [UIViewController] {
        return [
            RandomModule().buildModule(),
            FavouritesModule().buildModule()
        ].map { UINavigationController(rootViewController: $0) }
    }
    
    func display(_ viewController: [UIViewController]) {
        self.viewControllers = viewController
    }
}

//
//  HomeTabBarController.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 14/05/25.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    let tarBarAppearance:  UITabBarAppearance = {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.Unselected.primary
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.Unselected.primary]

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.Button.primary
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.Button.primary]

        return appearance
    }()
    
    lazy var dailyViewController: UINavigationController = {
        let title = "Daily"
        let image = UIImage(systemName: "calendar")
        let tabItem = UITabBarItem(
            title: title,
            image: image,
            selectedImage: image
        )

        let rootViewController = DailyViewController()
        rootViewController.tabBarItem = tabItem
    
        return UINavigationController(rootViewController: rootViewController)
    }()

    lazy var healthViewController: UINavigationController = {
        let title = "Health"
        let image = UIImage(systemName: "cross.case")
        let tabItem = UITabBarItem(
            title: title,
            image: image,
            selectedImage: image
        )

        // MARK: - Update this later with the proper VC
        let rootViewController = HealthViewController()
        rootViewController.tabBarItem = tabItem
    
        return UINavigationController(rootViewController: rootViewController)
    }()

    lazy var petsViewController: UINavigationController = {
        let title = "Pets"
        let image = UIImage(systemName: "pawprint")
        let tabItem = UITabBarItem(
            title: title,
            image: image,
            selectedImage: image
        )
        
        // MARK: - Update this later with the proper VC
        let rootViewController = PetsViewController()
        rootViewController.tabBarItem = tabItem
    
        return UINavigationController(rootViewController: rootViewController)
    }()
    
    lazy var mockDataViewController: UINavigationController = {
        let title = "Mock Data"
        let image = UIImage(systemName: "tray.and.arrow.down")
        let tabItem = UITabBarItem(
            title: title,
            image: image,
            selectedImage: image
        )
        
        // The view controller with the button to add mock data
        let mockVC = MockDataViewController()
        mockVC.tabBarItem = tabItem
        
        return UINavigationController(rootViewController: mockVC)
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [dailyViewController, healthViewController, petsViewController, mockDataViewController]
        tabBar.backgroundColor = .Background.primary
        tabBar.standardAppearance = tarBarAppearance
        
        addTabBarTopSeparator()
    }
}

extension HomeTabBarController {
    func addTabBarTopSeparator() {
        let separatorHeight: CGFloat = 1.0
        let separator = UIView()
        separator.backgroundColor = .Separator.primary
        separator.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(separator)
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -separatorHeight),
            separator.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: separatorHeight)
        ])
    }

}

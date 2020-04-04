//
//  TabBarViewController.swift
//  Budgeteeeii
//
//  Created by Dominique Michael Abejar on 3/27/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = createTabBarItem(tabBarTitle: "Composational Layout", tabBarImage: "square.stack.3d.up.fill", viewController: FirstViewController())
        let vc2 = createTabBarItem(tabBarTitle: "Pure Collection View", tabBarImage: "gamecontroller", viewController: SecondViewController())
        
        viewControllers = [vc1, vc2]
    }
    
    // MARK: - Methods
    
    private func createTabBarItem(tabBarTitle: String, tabBarImage: String, viewController: UIViewController) -> UINavigationController {
        
        let navCont = UINavigationController(rootViewController: viewController)
        navCont.tabBarItem.title = tabBarTitle
        navCont.tabBarItem.image = UIImage(systemName: tabBarImage)

        return navCont
    }
    
}

//
//  UINavigationBarExtension.swift
//  Budgeteeeii
//
//  Created by Dominique Michael Abejar on 3/27/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func navBarColor(textColor: UIColor, backgroundColor: UIColor) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: textColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: textColor]
        navBarAppearance.backgroundColor = backgroundColor
        
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func removeNavBarSeperator(){
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearence = UINavigationBarAppearance()
        
        navigationBarAppearence.shadowColor = .clear
        navigationBar?.scrollEdgeAppearance = navigationBarAppearence
    }
}


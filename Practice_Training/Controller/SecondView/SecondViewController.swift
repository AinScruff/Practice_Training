//
//  SecondViewController.swift
//  Budgeteeeii
//
//  Created by Dominique Michael Abejar on 3/27/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - Properties
     
     
    // MARK: - Lifecycle
     
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemBackground
        setUpNavBar()
    }
    
   

    // MARK: - Methods
    
    private func setUpNavBar() {
        navigationItem.title = "Second"
    }
    

}

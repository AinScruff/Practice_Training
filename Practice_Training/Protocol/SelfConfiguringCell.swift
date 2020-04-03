//
//  SelfConfiguringCell.swift
//  Budgeteeeii
//
//  Created by Dominique Michael Abejar on 4/3/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import Foundation

protocol SelfConfiguringCell {
    
    static var reuseIdentifier: String { get }
    
    func configure(with app: App)
}

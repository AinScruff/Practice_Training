//
//  App.swift
//  Practice_Training
//
//  Created by Dominique Michael Abejar on 4/3/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import Foundation

struct App: Decodable, Hashable {
    
    let id: Int
    let tagline: String
    let name: String
    let subheading: String
    let image: String
    let iap: Bool
}

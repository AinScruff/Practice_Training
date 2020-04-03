//
//  Section.swift
//  Practice_Training
//
//  Created by Dominique Michael Abejar on 4/3/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import Foundation

struct Section: Decodable, Hashable {
    
    let id: Int
    let type: String
    let title: String
    let subtitle: String
    let items: [App]
}

//
//  SecondViewSectionHeaderCollectionReusableView.swift
//  Practice_Training
//
//  Created by Dominique Michael Abejar on 4/11/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import UIKit

class SecondViewSectionHeaderView: UICollectionReusableView {
    
    // MARK: - View Elements
    
    var imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "firewatch"))
        
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints

extension SecondViewSectionHeaderView {
    
    fileprivate func setUpConstraints() {
        addSubview(imageView)
        
        imageView.fillSuperView()
    }
}

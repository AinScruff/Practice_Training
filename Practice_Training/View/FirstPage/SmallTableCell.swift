//
//  SmallTableCell.swift
//  Practice_Training
//
//  Created by Dominique Michael Abejar on 4/4/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import UIKit

class SmallTableCell: UICollectionViewCell{
   
    // MARK: - View Elements

    let nameLabel: UILabel = {
        
        let nl = UILabel()
        
        nl.font = UIFont.preferredFont(forTextStyle: .title2)
        nl.textColor = .label
        
        return nl
    }()
    
    let imageView: UIImageView = {
        
        let iv = UIImageView()
        
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        
        return iv
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SelfConfiguringCell Protocol

extension SmallTableCell: SelfConfiguringCell {
    
    static let reuseIdentifier: String = "Small Table"
     
    func configureViewElements(with app: App) {
        nameLabel.text = app.name
        imageView.image = UIImage(named: app.image)
    }
}

// MARK: - Contraints

extension SmallTableCell {
    func setupContraints() {
        
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        
        contentView.addSubview(stackView)
        
        stackView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor)
        stackView.alignment = .center
        stackView.spacing = 20
    }
}

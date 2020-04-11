//
//  FeaturedCell.swift
//  Budgeteeeii
//
//  Created by Dominique Michael Abejar on 4/3/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import UIKit

class FeaturedCell: UICollectionViewCell {
   
    // MARK: - View Elements
    
    let seperator: UIView = {
        
        let sep = UIView()
        
        sep.backgroundColor = .quaternaryLabel
        sep.translatesAutoresizingMaskIntoConstraints = false
        
        return sep
    }()
    
    let taglineLabel: UILabel = {
        
        let tl = UILabel()
        
        tl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        tl.textColor = .systemBlue

        return tl
    }()
    
    let nameLabel: UILabel = {
        
        let nl = UILabel()
        
        nl.font = UIFont.preferredFont(forTextStyle: .title2)
        nl.textColor = .label
        
        return nl
    }()
    
    let subtitleLabel: UILabel = {
        
        let sl = UILabel()
        
        sl.font = UIFont.preferredFont(forTextStyle: .title2)
        sl.textColor = .secondaryLabel
        
        return sl
    }()
    
    let imageView: UIImageView = {
        
        let iv = UIImageView()
        
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
    
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

extension FeaturedCell: SelfConfiguringCell {
    
    static let reuseIdentifier: String = "Featured"

    func configureViewElements(with app: App) {
        
        taglineLabel.text = app.tagline.uppercased()
        nameLabel.text = app.name
        subtitleLabel.text = app.subheading
        imageView.image = UIImage(named: app.image)
    }
}

// MARK: - Constraints

extension FeaturedCell {
    
    private func setupContraints() {
        
        let stackView = UIStackView(arrangedSubviews: [seperator, taglineLabel, nameLabel, subtitleLabel, imageView])
        
        contentView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            seperator.heightAnchor.constraint(equalToConstant: 1),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
        
        stackView.setCustomSpacing(10, after: seperator)
        stackView.setCustomSpacing(10, after: subtitleLabel)

    }
}

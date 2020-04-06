//
//  MediumCell.swift
//  Practice_Training
//
//  Created by Dominique Michael Abejar on 4/3/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import UIKit

class MediumCell: UICollectionViewCell, SelfConfiguringCell {
    
    
    // MARK: - Properties
    
    static let reuseIdentifier: String = "Medium"
    
    let nameLabel: UILabel = {
        let nl = UILabel()
        
        nl.font = UIFont.preferredFont(forTextStyle: .headline)
        nl.textColor = .label
        
        return nl
    }()
    
    let subtitleLabel: UILabel = {
        let sl = UILabel()
        
        sl.font = UIFont.preferredFont(forTextStyle: .subheadline)
        sl.textColor = .secondaryLabel
        
        return sl
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        iv.setContentHuggingPriority(.defaultHigh ,for: .horizontal)
        
        return iv
    }()
    
    let buyButton: UIButton = {
        let bb = UIButton(type: .system)
        
        bb.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        bb.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return bb
    }()
    
    var mark = 0
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    
    private func setUp() {
        
        // InnerStackView
        
        let innerStackView = UIStackView(arrangedSubviews: [nameLabel, subtitleLabel])
        
        innerStackView.axis = .vertical
        
        // OuterStackView
        let outerStackView = UIStackView(arrangedSubviews: [imageView, innerStackView, buyButton])
        contentView.addSubview(outerStackView)
        
        outerStackView.alignment = .center
        outerStackView.spacing = 10
        outerStackView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor)

    }
    
    func configure(with app: App) {
        nameLabel.text = app.name
        subtitleLabel.text = app.subheading
        imageView.image = UIImage(named: app.image)
        buyButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc func buttonTapped(sender: UIButton) {
        
        if mark == 0 {
            buyButton.setImage(UIImage(systemName: "gamecontroller"), for: .normal)
            mark += 1
        } else {
            buyButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
            mark -= 1
        }
        
    }
    
}

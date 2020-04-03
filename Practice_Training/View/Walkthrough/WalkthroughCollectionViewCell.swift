//
//  WalkthroughCollectionViewCell.swift
//  Budgeteeeii
//
//  Created by Dominique Michael Abejar on 4/1/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import UIKit

class WalkthroughCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - Properties
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return }
            
            imageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.titleHeader, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
            
            attributedText.append(NSMutableAttributedString(string: "\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.gray]))
            
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
            
        }
    }
    
    private let topImageContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        return containerView
    }()
           
   private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    // MARK: - Methods
    
    private func setUpLayout() {
        
        // Container View
        addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        // Image View
        topImageContainerView.addSubview(imageView)
        imageView.anchor(centerX: topImageContainerView.centerXAnchor, centerY: topImageContainerView.centerYAnchor)
        imageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        // Description View
        addSubview(descriptionTextView)
        descriptionTextView.anchor(top: topImageContainerView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

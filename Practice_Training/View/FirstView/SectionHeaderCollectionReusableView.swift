//
//  SectionHeaderCollectionReusableView.swift
//  Practice_Training
//
//  Created by Dominique Michael Abejar on 4/3/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import UIKit

class SectionHeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "SectionHeader"
    
    // MARK: - View Elements
    let titleLabel: UILabel = {
        
        let tl = UILabel()
        
        tl.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 22, weight: .bold))
        tl.textColor = .label
        
        return tl
    }()
    
    let subtitleLabel: UILabel = {
        
        let sl = UILabel()
        
        sl.textColor = .secondaryLabel
        
        return sl
    }()
    
    let separator: UIView = {
        let sv = UIView()
        
        sv.backgroundColor = .quaternaryLabel
        
        return sv
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints

extension SectionHeaderCollectionReusableView {
    
    func setUpContraints() {
          
          let stackView = UIStackView(arrangedSubviews: [separator, titleLabel, subtitleLabel])
          
          stackView.axis = .vertical
          addSubview(stackView)
          
          separator.anchor(height: 1)
          stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingBottom: 10)
          stackView.setCustomSpacing(10, after: separator)
      }
}

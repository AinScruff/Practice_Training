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
    
    let cellId = "cell"
    let headerCellId = "headerCell"

    // MARK: - View Elements
    
    let collectionViewLayout = UICollectionViewFlowLayout()
    
    lazy var collectionView: UICollectionView = {
        
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        
        cv.backgroundColor = .systemBackground
        
        return cv
    }()
    
    var padding: CGFloat = 16
     
    // MARK: - Lifecycle
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
    }
}

// MARK: - Constraints

extension SecondViewController {
    
    func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        
        registerCollectionViewCells()
        paddingCells()
    }
    
    func registerCollectionViewCells() {
        
        // Register Header Cell
        collectionView.register(SecondViewSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        
        // Register Cells
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func paddingCells() {
        
        collectionViewLayout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        
        collectionViewLayout.minimumLineSpacing = 40
    }
}

//
//  FirstViewController.swift
//  Budgeteeeii
//
//  Created by Dominique Michael Abejar on 3/26/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
        
    // MARK: - Properties
    
    let sections = Bundle.main.decode([Section].self, from: "appstore.json")
    
    var dataSource: UICollectionViewDiffableDataSource<Section, App>?
    
    // MARK: - View Elements
    
    lazy var collectionView: UICollectionView = {
    
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())

        cv.backgroundColor = .systemBackground
        
        return cv
    }()
    
    private let floatingButton: UIButton = {
        
        let bb = UIButton(type: .custom)
        let image = UIImage(named: "quill")?.withRenderingMode(.alwaysTemplate)
        
        // Prevent UITintColor to go gray when clicked
        bb.adjustsImageWhenHighlighted = false
        
        bb.backgroundColor = UIColor(hex: "#00B2FFFF")
        bb.layer.masksToBounds = true
        
        bb.setImage(image, for: .normal)
        bb.tintColor = .white
        
        // Circle Button Frame
        bb.frame = CGRect(x: 0, y: 0, width: 65, height: 65)
        bb.layer.cornerRadius = bb.frame.width / 2
       
        bb.addTarget(self, action: #selector(addTest), for: .touchUpInside)
        
        return bb
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemBackground
        
        setUpCollectionView()
        setUpFloatingButton()
       
        createDatasource()
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigateToWalkThroughPage()
    }
}

// MARK: - Constraints

extension FirstViewController {
    
    private func setUpNavBar() {
        
        navigationItem.title = "First"
        navigationItem.largeTitleDisplayMode = .automatic
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navBarColor(textColor: .label, backgroundColor: .systemBackground)
        navigationController?.removeNavBarSeperator()
    }
    
    private func setUpFloatingButton() {
        
        view.addSubview(floatingButton)
        floatingButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, paddingBottom: 15, paddingTrailing: 15, width: 65, height: 65)
    }

    private func setUpCollectionView() {
        
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        
        // Register Cells
        collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
        collectionView.register(MediumCell.self, forCellWithReuseIdentifier: MediumCell.reuseIdentifier)
        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderCollectionReusableView.reuseIdentifier)
        collectionView.register(SmallTableCell.self, forCellWithReuseIdentifier: SmallTableCell.reuseIdentifier)
    }

    private func navigateToWalkThroughPage() {
        if userSecondTime(){
            return
        }
         
        let vc = WalkthroughCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
         
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - Methods

extension FirstViewController {
    
    private func userSecondTime() -> Bool {
        return UserDefaults.standard.bool(forKey: "hasViewedWalkthrough")
    }
    
    @objc private func addTest() {
        floatingButton.pulsate()
    }
}

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
    
    fileprivate lazy var collectionView: UICollectionView = {
    
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createComposationalLayout())

        cv.backgroundColor = .systemBackground
        
        return cv
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, App>?
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemBackground
        
        setUpCollectionView()
     
        
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
    
    
    // MARK: - Setup Methods

    private func setUpNavBar() {
        
        navigationItem.title = "First"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        navigationController?.navBarColor(textColor: .label, backgroundColor: .systemBackground)
        navigationController?.removeNavBarSeperator()
    }

    private func setUpCollectionView() {
        
        view.addSubview(collectionView)
        
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        // Register Cells
        collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
        collectionView.register(MediumCell.self, forCellWithReuseIdentifier: MediumCell.reuseIdentifier)
        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderCollectionReusableView.reuseIdentifier)
    }

    private func configureCell<T: SelfConfiguringCell>(_ cellType: T.Type, with app: App, for indexPath: IndexPath) -> T {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else { fatalError("Cannot dequeue") }
        
        
        cell.configure(with: app)

        return cell
    }
    
    // MARK: - Methods
    
    private func navigateToWalkThroughPage() {
        
        // If user hasn't viewed walkthrough then show
        
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
             return
         }
         
        
         let vc = WalkthroughCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
         
         vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
         self.present(vc, animated: true, completion: nil)
    }
    
    private func createDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Section, App>(collectionView: collectionView) { collectionView, indexPath, app in
             
            switch self.sections[indexPath.section].type {
            case "mediumTable":
                return self.configureCell(MediumCell.self, with: app, for: indexPath)
            default:
                return self.configureCell(FeaturedCell.self, with: app, for: indexPath)
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as? SectionHeaderCollectionReusableView else { return  nil }
            
            guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { return nil }
            
            if section.title.isEmpty { return nil }
            
            sectionHeader.titleLabel.text = section.title
            sectionHeader.subtitleLabel.text = section.subtitle
            
            return sectionHeader
        }
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, App>()
        
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    
}

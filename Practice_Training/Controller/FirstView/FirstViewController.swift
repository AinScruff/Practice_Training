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
        
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        
        let vc = WalkthroughCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
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
        
        // Register Cell
        collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
    }

    private func configureCell<T: SelfConfiguringCell>(_ cellType: T.Type, with app: App, for indexPath: IndexPath) -> T {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else { fatalError("Cannot dequeue") }
        
        
        cell.configure(with: app)

        return cell
    }
    
    // MARK: - Methods
    
    private func createDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Section, App>(collectionView: collectionView) { collectionView, indexPath, app in
            
            switch self.sections[indexPath.section].type {
            default:
                return self.configureCell(FeaturedCell.self, with: app, for: indexPath)
            }
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

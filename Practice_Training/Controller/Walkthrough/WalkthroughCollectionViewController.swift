//
//  WalkthroughCollectionViewController.swift
//  Budgeteeeii
//
//  Created by Dominique Michael Abejar on 4/1/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import UIKit


class WalkthroughCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    
    let reuseIdentifier = "Cell"
    
    var endPage = 0
    
    let pages = [ Page(imageName: "apple", titleHeader: "Apple", bodyText: "Buy now from Apple INC."), Page(imageName: "android", titleHeader: "Android", bodyText: "Buy Android Phones"), Page(imageName: "linux", titleHeader: "Linux", bodyText: "Linux Pengu pengu pengu"), Page(imageName: "windows", titleHeader: "Windows", bodyText: "Affordable OS bla bla bla")]
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("PREVIOUS", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor(hex: "#F2688AFF"), for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        return button
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = UIColor(hex: "#F2688AFF")
        pc.pageIndicatorTintColor = .gray
        
        return pc
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        
        // Register cell classes
        collectionView!.register(WalkthroughCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        swipeControl()
        
        setUpButton()
    }
    
    // MARK: - Setup Methods
    
    private func swipeControl() {
        collectionView.isPagingEnabled = true
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    private func setUpButton() {
        
        // Stack View
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        bottomControlsStackView.anchor(left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, height: 50)
    }
    
    // MARK: - Button Selector Methods
    
    @objc private func handleNext() {
        
        if pageControl.currentPage == pages.count - 1 {
            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
            self.dismiss(animated: true, completion: nil)
        }
        
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
    
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handlePrev() {
        
        let prevIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        
        pageControl.currentPage = prevIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

}

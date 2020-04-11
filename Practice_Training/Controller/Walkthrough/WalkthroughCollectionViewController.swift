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

    let pages = [ Page(imageName: "apple", titleHeader: "Apple", bodyText: "Buy now from Apple INC."), Page(imageName: "android", titleHeader: "Android", bodyText: "Buy Android Phones"), Page(imageName: "linux", titleHeader: "Linux", bodyText: "Linux Pengu pengu pengu"), Page(imageName: "windows", titleHeader: "Windows", bodyText: "Affordable OS bla bla bla")]
    
    var pageNumber = 0
    
    // MARK: - View Elements
    
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

        setUpCollectionView()
        setUpButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

// MARK: - Contraints

extension WalkthroughCollectionViewController {
  
    private func setUpCollectionView() {
        
        collectionView.backgroundColor = .white
        collectionView!.register(WalkthroughCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
}

// MARK: - Button Selector Methods

extension WalkthroughCollectionViewController {
    
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

// MARK: - Swipe Methods

extension WalkthroughCollectionViewController {
    
    // Handle Swipe Gesture to Prev/Next Controller
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).x > 0 {
            if pageNumber != 0 {
                pageNumber -= 1
            }
        } else {
            if pageNumber == pages.count - 1 {
               UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
               self.dismiss(animated: true, completion: nil)
            } else {
               pageNumber += 1
            }
        }
        
        
    }

}

//
//  WalkthroughCollection+Extension.swift
//  Budgeteeeii
//
//  Created by Dominique Michael Abejar on 4/3/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import Foundation
import UIKit

extension WalkthroughCollectionViewController {
    
    // Handle Swipe Gesture to Prev/Next Controller
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)

        if endPage == pages.count - 1{
            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
            self.dismiss(animated: true, completion: nil)
        } else {
            endPage = pageControl.currentPage
        }
        
    }
    
    // Handle Horizontal View of phone
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        
        }) { (_) in
        
        }
    }
}

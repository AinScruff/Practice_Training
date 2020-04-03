//
//  FirstView+UICollectionView.swift
//  Budgeteeeii
//
//  Created by Dominique Michael Abejar on 4/3/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import Foundation
import UIKit

extension FirstViewController {
     
    // MARK: - CollectionView Compositional Layout Methods
        
    func createComposationalLayout() -> UICollectionViewLayout {
            
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
                
            let section = self.sections[sectionIndex]
                
            switch section.type {
            case "mediumTable":
                return self.createMediumSection(using: section)
            default:
                return self.createFeaturedSection(using: section)
            }
        }
            
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
            
        return layout
    }
        
    func createFeaturedSection(using section: Section) -> NSCollectionLayoutSection{
        
        // Item Size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        // Item
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
               
        // Group Size
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(350))
        
        // Group
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        // Section
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
            
        return layoutSection
    }
    
    func createMediumSection(using section: Section) -> NSCollectionLayoutSection {
        
        // Item Size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        
        // Item
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        // Group Size
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
        
        // Group
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        // Section
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        // Section Header Size
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
}

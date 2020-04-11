//
//  FirstView+UICollectionView.swift
//  Budgeteeeii
//
//  Created by Dominique Michael Abejar on 4/3/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CollectionView Delegate

extension FirstViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let data = dataSource?.itemIdentifier(for: indexPath) else { return }
        
        print(data)
    }
}

// MARK: - CollectionView DataSource

extension FirstViewController {
   
    func configureCell<T: SelfConfiguringCell>(_ cellType: T.Type, with app: App, for indexPath: IndexPath) -> T {
           
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else { fatalError("Cannot dequeue") }
                   
        cell.configureViewElements(with: app)

        return cell
    }

    func createDatasource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, App>(collectionView: collectionView) { collectionView, indexPath, app in
                
            switch self.sections[indexPath.section].type {
            case "mediumTable":
                return self.configureCell(MediumCell.self, with: app, for: indexPath)
            case "smallTable":
                return self.configureCell(SmallTableCell.self, with: app, for: indexPath)
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
       
    func reloadData() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, App>()
           
        snapshot.appendSections(sections)
           
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
           
        dataSource?.apply(snapshot)
      }
}



// MARK: - CollectionView Compositional Layout

extension FirstViewController {
    
    func createCompositionalLayout() -> UICollectionViewLayout {
            
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
                
            let section = self.sections[sectionIndex]
                
            switch section.type {
            case "smallTable":
                return self.createSmallSection(using: section)
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
    
    // MARK: - Setup Sections
    
    private func createFeaturedSection(using section: Section) -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
               
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(350))
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
            
        return layoutSection
    }
    
    private func createMediumSection(using section: Section) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        layoutSection.boundarySupplementaryItems = [createSectionHeader()]
        
        return layoutSection
    }
    
    private func createSmallSection(using section: Section) -> NSCollectionLayoutSection {
        
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(200))
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        layoutSection.boundarySupplementaryItems = [createSectionHeader()]
        
        return layoutSection
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return layoutSectionHeader
    }
}

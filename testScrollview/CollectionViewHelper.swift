//
//  CollectionViewHelper.swift
//  testScrollview
//
//  Created by IT-17426-THANH on 03/04/2024.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerCells(identifies: [String]){
        for id in identifies {
            let nib = UINib(nibName: id, bundle: nil)
            self.register(nib, forCellWithReuseIdentifier: id)
        }
    }

    func registerHeader(identifies: [String]){
        for id in identifies {
            let nib = UINib(nibName: id, bundle: nil)
            register(nib, forSupplementaryViewOfKind:  UICollectionView.elementKindSectionHeader,
                     withReuseIdentifier: id)
        }
    }
    
    func registerFooter(identifies: [String]){
        for id in identifies {
            let nib = UINib(nibName: id, bundle: nil)
            register(nib, forSupplementaryViewOfKind:  UICollectionView.elementKindSectionFooter,
                     withReuseIdentifier: id)
        }
    }
    
    func dequeueCell<T>(ofType type: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                   for: indexPath)  as! T
    }
    
    func dequeHeader<T>(ofType type: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: String(describing: T.self),
                                         for: indexPath) as! T
    }
    
    func dequeFooter<T>(ofType type: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                         withReuseIdentifier: String(describing: T.self),
                                         for: indexPath) as! T
    }
    var visibleCurrentCellIndexPath: IndexPath? {
        for cell in self.visibleCells {
            let indexPath = self.indexPath(for: cell)
            return indexPath
        }
        
        return nil
    }
    
    
    
    func scrolltoTop(animation: Bool) {
        let topIndexPath = IndexPath(row: .zero, section: .zero)
        if indexPathExists(indexPath: topIndexPath) {
            self.scrollToItem(at: topIndexPath, at: .top, animated: animation)
        }
    }
    
    func indexPathExists(indexPath: IndexPath) -> Bool {
        if indexPath.section >= self.numberOfSections {
            return false
        }
        if indexPath.row >= self.numberOfItems(inSection: indexPath.section) {
            return false
        }
        return true
    }
}

extension UICollectionView {
    
    func scrollToNextItem(completion: () -> ()) {
        let scrollOffset = CGFloat(floor(self.contentOffset.y + 10))
        self.scrollToFrame(scrollOffset: scrollOffset)
        completion()
    }
    
    func scrollToPreviousItem() {
        let scrollOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
        self.scrollToFrame(scrollOffset: scrollOffset)
    }
    
    func scrollToFrame(scrollOffset : CGFloat) {
        guard scrollOffset <= self.contentSize.height - self.bounds.size.height else { return }
        guard scrollOffset >= 0 else { return }
        self.setContentOffset(CGPoint(x: self.contentOffset.x, y: scrollOffset), animated: true)
    }
}

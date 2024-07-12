//
//  CollectionViewViewController.swift
//  testScrollview
//
//  Created by IT-17426-THANH on 03/04/2024.
//

import UIKit

class CollectionViewViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var loadingDiscoveryDataSource: VideoHastagLoadingDataSource?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingDiscoveryDataSource = VideoHastagLoadingDataSource(collectionView: collectionView)
        collectionView.dataSource = loadingDiscoveryDataSource
        collectionView.reloadData()
        // Do any additional setup after loading the view.
        
        
        
        
        
        
        
        
        
    }
    
}

#Preview {
    let articleViewController = CollectionViewViewController.instantiateFromStoryboard(storyboardName: "Main")
    
    return articleViewController
}



extension NSObject {
    public var className: String {
        return type(of: self).className
    }
    
    public static var className: String {
        return String(describing: self)
    }
}


/*
class VideoDiscoveryLoadingDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: VideoShoppingCollectionViewCell.self, indexPath: indexPath)
        return cell
    }
    
    
    init(collectionView: UICollectionView) {
        super.init()
        collectionView.delegate = self
        collectionView.registerCells(identifies: [VideoShoppingCollectionViewCell.className])
    }
}

extension VideoDiscoveryLoadingDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
           let itemWidth = (collectionViewWidth) / 2 - 16
           let itemHeight = (itemWidth * 319) / 199
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: 0, right: 10)
    }
 }
*/


class VideoDiscoveryDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: VideoShoppingCollectionViewCell.self, indexPath: indexPath)
        return cell
    }
    
    
    init(collectionView: UICollectionView) {
        super.init()
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.registerCells(identifies: [VideoShoppingCollectionViewCell.className])
    }
    
}
 
extension VideoDiscoveryDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = UIScreen.main.bounds.size.width
        /*
        let itemWidth = (collectionViewWidth)
        let itemHeight: CGFloat =  (itemWidth * 428) / 416
         return CGSize(width: itemWidth , height: getCellFaqHeight())
        */
        let collectionViewHeight = collectionView.bounds.size.height
        return CGSize(width: collectionViewWidth , height: collectionViewHeight)
        
        
    }
    
    func getCellFaqHeight() -> CGFloat {
        let collectionViewWidth = UIScreen.main.bounds.size.width
        let imageHeight = (collectionViewWidth - 20) * 260 / 408
        let largeTitleHeight: CGFloat = 45
        let smallTitlteHeight: CGFloat = 54
        let reactionHeight: CGFloat = 12
        let finalHeight: CGFloat = imageHeight + 12 + largeTitleHeight + 8 + smallTitlteHeight + 12 + reactionHeight + 10
        return finalHeight
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}




class ProductVideoShoppingDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: ProductVideoShoppingCollectionViewCell.self, indexPath: indexPath)
        return cell
    }
    
    
    init(collectionView: UICollectionView) {
        super.init()
        collectionView.delegate = self 
        
         collectionView.registerCells(identifies: [ProductVideoShoppingCollectionViewCell.className])
    }
}

extension ProductVideoShoppingDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.size.width
        let collectionViewHeight = collectionView.bounds.size.height
        return CGSize(width: collectionViewWidth , height: collectionViewHeight)
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}



class VideoHastagLoadingDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: VideoDiscoveryLoadingCollectionViewCell.self, indexPath: indexPath)
        cell.imageBg.image = UIImage(named: "HastagLoadingBG")
        return cell
    }
    
    
    init(collectionView: UICollectionView) {
        super.init()
        collectionView.delegate = self
        collectionView.registerCells(identifies: [VideoDiscoveryLoadingCollectionViewCell.className])
    }
}

extension VideoHastagLoadingDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = UIScreen.main.bounds.width
           let itemWidth = (collectionViewWidth - 20)
           let itemHeight = (itemWidth * 300) / 413
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
}

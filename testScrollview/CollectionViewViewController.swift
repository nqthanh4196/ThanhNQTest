//
//  CollectionViewViewController.swift
//  testScrollview
//
//  Created by IT-17426-THANH on 03/04/2024.
//

import UIKit

class CollectionViewViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var loadingDiscoveryDataSource: VideoDiscoveryDataSource?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingDiscoveryDataSource = VideoDiscoveryDataSource(collectionView: collectionView)
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


class VideoDiscoveryLoadingDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: VideoDiscoveryLoadingCollectionViewCell.self, indexPath: indexPath)
        return cell
    }
    
    
    init(collectionView: UICollectionView) {
        super.init()
        collectionView.delegate = self
        collectionView.registerCells(identifies: [VideoDiscoveryLoadingCollectionViewCell.className])
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


class VideoDiscoveryDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: VideoFaqCollectionViewCell.self, indexPath: indexPath)
        return cell
    }
    
    
    init(collectionView: UICollectionView) {
        super.init()
        collectionView.delegate = self
        collectionView.registerCells(identifies: [VideoFaqCollectionViewCell.className])
    }
}

extension VideoDiscoveryDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
           let itemWidth = (collectionViewWidth - 20)
        let itemHeight: CGFloat = 416
        return CGSize(width: itemWidth , height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
    }
    
}

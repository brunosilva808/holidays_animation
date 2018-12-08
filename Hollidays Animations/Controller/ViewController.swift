//
//  ViewController.swift
//  Hollidays Animations
//
//  Created by Bruno Silva on 05/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let zoomDelegate = ZoomTransitioningDelegate()
    var selectedIndexPath: IndexPath!
    var array: [Holiday] = [Holiday(imageName: "1"),
                            Holiday(imageName: "2"),
                            Holiday(imageName: "3"),
                            Holiday(imageName: "4"),
                            Holiday(imageName: "1"),
                            Holiday(imageName: "2"),
                            Holiday(imageName: "3"),
                            Holiday(imageName: "4"),
                            Holiday(imageName: "1"),
                            Holiday(imageName: "2"),
                            Holiday(imageName: "3"),
                            Holiday(imageName: "4"),
                            Holiday(imageName: "1"),
                            Holiday(imageName: "2"),
                            Holiday(imageName: "3"),
                            Holiday(imageName: "4"),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.collectionView.backgroundColor = .white
        self.collectionView.register(CollectionCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 176)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.reusableCell(for: indexPath, with: self.array[indexPath.row]) as CollectionCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.array.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.model = array[indexPath.row]
        self.navigationController?.delegate = zoomDelegate
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
        self.selectedIndexPath = indexPath
    }
    
//    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//        cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height/2)
//
//        UIView.animate(withDuration: 0.5, delay: 0.01 * Double(indexPath.row), options: [.curveEaseInOut], animations: {
//            cell.transform = CGAffineTransform(translationX: 0, y: 0)
//        }, completion: nil)
//    }
    
}

extension ViewController: ZoomingViewController {
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        if let indexPath = self.selectedIndexPath {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionCell
            return cell.imageView
        }
        
        return nil
    }
    
    func zoomingBackgroundImageView(for transition: ZoomTransitioningDelegate) -> UIView? {
        return nil
    }
}

//
//  CollectionCellCollectionViewCell.swift
//  Hollidays Animations
//
//  Created by Bruno Silva on 05/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell, ModelPresenterCell {
    
    var model: Holiday? {
        didSet {
            guard let model = self.model else { return }
            imageView.image = UIImage(named: model.imageName)
        }
    }
    
    let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.setRoundedCorners(toRadius: 15)
        view.setShadow(color: .black, radius: 5)
        return view
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.setRoundedCorners(toRadius: 15)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(self.shadowView)
        self.addSubview(self.imageView)
        
        self.addConstraintsWithFormat("H:|-16-[v0]-16-|", views: shadowView)
        self.addConstraintsWithFormat("V:|-8-[v0]-16-|", views: shadowView)
        
        self.addConstraintsWithFormat("H:|-16-[v0]-16-|", views: imageView)
        self.addConstraintsWithFormat("V:|-8-[v0]-16-|", views: imageView)
        
//        self.addConstraintsWithFormat("V:|-8-[v0][v1][v0]-16-|", views: imageView, shadowView)
//        self.addConstraintsWithFormat("H:|-16-[v0][v1][v0]-16-|", views: imageView, shadowView)
    }
    
}

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
            titleLabel.text = model.title
        }
    }
    
    let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.set(style: .shadow)
        return view
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.set(style: .cell)
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.set(style: .title)
        return label
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
        self.addSubview(self.titleLabel)
        
        self.addConstraintsWithFormat("H:|-16-[v0]-16-|", views: shadowView)
        self.addConstraintsWithFormat("V:|-8-[v0]-16-|", views: shadowView)
        
        self.addConstraintsWithFormat("H:|-16-[v0]-16-|", views: imageView)
        self.addConstraintsWithFormat("V:|-8-[v0]-16-|", views: imageView)
        
        self.addConstraintsWithFormat("H:|-32-[v0]-32-|", views: titleLabel)
        self.addConstraintsWithFormat("V:[v0]-32-|", views: titleLabel)
        
//        self.addConstraintsWithFormat("V:|-8-[v0][v1][v0]-16-|", views: imageView, shadowView)
//        self.addConstraintsWithFormat("H:|-16-[v0][v1][v0]-16-|", views: imageView, shadowView)
    }
    
}

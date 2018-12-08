//
//  DetailViewController.swift
//  Hollidays Animations
//
//  Created by Carbon on 08/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var model: Holiday? {
        didSet {
            guard let model = self.model else { return }
            imageView.image = UIImage(named: model.imageName)
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
        setupViews()
    }
    
    func setupViews() {
        self.view.addSubview(imageView)
        
        self.view.addConstraintsWithFormat("H:|[v0]|", views: imageView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: imageView)
    }

}

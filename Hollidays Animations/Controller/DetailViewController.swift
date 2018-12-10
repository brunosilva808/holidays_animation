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
            imageView2.image = UIImage(named: model.imageName)
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleToFill
        imageView.tag = 99
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bottomView: UIView = {
        let view = UIView(frame: .zero)
//        view.tag = 98
        view.backgroundColor = .blue
        return view
    }()
    
    let imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleToFill
        imageView.tag = 98
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTouched))
        self.imageView.addGestureRecognizer(tapGesture)
        setupViews()
    }
    
    func setupViews() {
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.imageView2)
        
        self.view.addConstraintsWithFormat("H:|[v0]|", views: self.imageView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: self.imageView)
        
        self.view.addConstraintsWithFormat("H:|[v0]|", views: self.imageView2)
        self.view.addConstraintsWithFormat("V:[v0(244)]|", views: self.imageView2)
    }

    @objc func imageTouched() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension DetailViewController: ZoomingViewController {
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        return self.imageView
    }
    
    func zoomingBackgroundImageView(for transition: ZoomTransitioningDelegate) -> UIView? {
        return nil 
    }
}

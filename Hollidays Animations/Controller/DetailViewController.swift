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
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let detailView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.setRoundedCorners(toRadius: 15)
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTouched))
        self.imageView.addGestureRecognizer(tapGesture)
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(viewTouched))
        self.detailView.addGestureRecognizer(tapGesture1)
        setupViews()
    }
    
    func setupViews() {
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.detailView)
        
        self.view.addConstraintsWithFormat("H:|[v0]|", views: imageView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: imageView)
        
        self.view.addConstraintsWithFormat("H:|[v0]|", views: detailView)
        self.view.addConstraintsWithFormat("V:[v0(344)]-(-100)-|", views: detailView)
    }

    @objc func imageTouched() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func viewTouched() {
        print("viewTouched")
    }
    
}

extension DetailViewController: ZoomingViewController {
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        return self.imageView
    }
    
    func zoomingBackgroundImageView(for transition: ZoomTransitioningDelegate) -> UIView? {
        return self.detailView
    }
}

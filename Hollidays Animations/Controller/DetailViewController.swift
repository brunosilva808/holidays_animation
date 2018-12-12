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
            titleLabel.text = model.title
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    static let detailViewHeight: CGFloat = UIScreen.main.bounds.height / 2
    static let detailViewMargin: CGFloat = 100.0
    let detailView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: detailViewHeight))
        view.set(style: .detail)
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
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
        self.view.addSubview(self.titleLabel)
        
        self.view.addConstraintsWithFormat("H:|[v0]|", views: imageView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: imageView)
        
//        let margin: CGFloat = 100.0
        let metrics = ["height": DetailViewController.detailViewHeight]
        self.view.addConstraintsWithFormat("H:|[v0]|", views: detailView)
        self.view.addConstraintsWithFormat("V:[v0(height)]-(-100)-|", views: detailView, metrics: metrics)
        
        self.view.addConstraintsWithFormat("H:|-32-[v0]-32-|", views: titleLabel)
        self.view.addConstraintsWithFormat("V:[v0]-32-[v1]", views: titleLabel, detailView)
    }

    @objc func imageTouched() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func viewTouched() {
        print("viewTouched")
    }
    
}

extension DetailViewController: ZoomingViewController {
    func zoomingTitleLabel(for transition: ZoomTransitioningDelegate) -> UILabel? {
        return self.titleLabel
    }
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        return self.imageView
    }
    
    func zoomingDetailView(for transition: ZoomTransitioningDelegate) -> UIView? {
        return self.detailView
    }
}

//
//  InfoViewController.swift
//  Hollidays Animations
//
//  Created by Carbon on 09/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    var model: Holiday? {
        didSet {
            guard let model = self.model else { return }
            self.titleLabel.text = model.title
            self.descriptionLabel.text = model.description
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
//        setupPanGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.setRoundedCorners(toRadius: 15)
        self.view.backgroundColor = .white
    }
    
    func setupViews() {
        
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.descriptionLabel)
        
        self.view.addConstraintsWithFormat("H:|-16-[v0]-16-|", views: self.titleLabel)
        
        self.view.addConstraintsWithFormat("H:|-16-[v0]-16-|", views: self.descriptionLabel)
        self.view.addConstraintsWithFormat("V:|-16-[v0(21)]-16-[v1]", views: self.titleLabel, self.descriptionLabel)
    }
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer(_:)))
        self.view.addGestureRecognizer(panGesture)
    }
    
    @objc func panGestureRecognizer(_ gesture: UIPanGestureRecognizer) {
        print(self.view.frame)
        let translation = gesture.translation(in: self.view)
        
        self.view.frame.origin = translation
        print(self.view.frame)
        
        if gesture.state == .ended {
            let velocity = gesture.velocity(in: self.view)
            
            if velocity.y >= 1500 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.4) {
                    self.view.frame.origin = .zero
                }
            }
        }
    }
    
}

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
    }
    
    func setupViews() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.descriptionLabel)
        
        self.view.addConstraintsWithFormat("H:|-16-[v0]-16-|", views: self.titleLabel)
        
        self.view.addConstraintsWithFormat("H:|-16-[v0]-16-|", views: self.descriptionLabel)
        self.view.addConstraintsWithFormat("V:|-16-[v0(21)]-16-[v1]", views: self.titleLabel, self.descriptionLabel)
    }
    
}

//
//  UIView+Extension.swift
//  Hollidays Animations
//
//  Created by Bruno Silva on 05/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

enum UIViewStyle {
    case detail
    case shadow
}

extension UIView {
    
    func set(style: UIViewStyle) {
        switch style {
        case .detail:
            self.isUserInteractionEnabled = true
            self.setRoundedCorners(toRadius: 15)
            self.backgroundColor = .white
        case .shadow:
            self.backgroundColor = .white
            self.setRoundedCorners(toRadius: 15)
            self.setShadow(color: .black, radius: 5)
        }
    }
    
    func addConstraintsWithFormat(_ format: String, views: UIView..., metrics: [String: Any]? = nil) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: metrics, views: viewsDictionary))
    }
    
    func setRoundedCorners(toRadius radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func setShadow(color: UIColor, radius: CGFloat, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 1.0
    }
    
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
    
}

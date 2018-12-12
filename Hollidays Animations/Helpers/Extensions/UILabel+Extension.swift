//
//  UILabel+Extension.swift
//  Hollidays Animations
//
//  Created by Carbon on 12/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

enum UILabelStyle {
    case title
}

extension UILabel {
    
    func set(style: UILabelStyle) {
        switch style {
        case .title:
            self.textColor = .white
            self.font = UIFont.boldSystemFont(ofSize: 21)
        }
    }
    
}

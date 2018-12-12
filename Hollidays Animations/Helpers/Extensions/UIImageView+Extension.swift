//
//  UIImage+Extension.swift
//  Hollidays Animations
//
//  Created by Carbon on 12/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

enum UIImageStyle {
    case cell
}

extension UIImageView {
    
    func set(style: UIImageStyle) {
        switch style {
        case .cell:
            self.translatesAutoresizingMaskIntoConstraints = false
            self.setRoundedCorners(toRadius: 15)
            self.contentMode = .scaleAspectFill
        }
    }
}

//
//  SlideInPresentationManager.swift
//  Hollidays Animations
//
//  Created by Carbon on 09/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

enum PresentationDirection {
    case left
    case top
    case right
    case bottom
}

class SlideInPresentationManager: NSObject {

    var direction = PresentationDirection.bottom
}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController =  SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction)
        
        return presentationController
    }
}




























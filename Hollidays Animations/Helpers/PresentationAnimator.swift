//
//  PresentationAnimator.swift
//  Hollidays Animations
//
//  Created by Carbon on 09/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

class PresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        let containerView = transitionContext.containerView
        let animationDuration = transitionDuration(using: transitionContext)
        
        toViewController.view.transform = CGAffineTransform(translationX: containerView.bounds.width, y: 0)
        toViewController.view.layer.shadowColor = UIColor.black.cgColor
        toViewController.view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        toViewController.view.layer.shadowOpacity = 0.3
        toViewController.view.layer.cornerRadius = 4.0
        toViewController.view.clipsToBounds = true
        
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: animationDuration, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
    

}

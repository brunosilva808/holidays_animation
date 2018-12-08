//
//  ZoomTransitioningDelegate.swift
//  Hollidays Animations
//
//  Created by Carbon on 08/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

@objc
protocol ZoomingViewController {
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView?
    func zoomingBackgroundImageView(for transition: ZoomTransitioningDelegate) -> UIView?
}

enum TransitionState {
    
    case inital
    case final
}

class ZoomTransitioningDelegate: NSObject {
    
    var transitionDuration = 0.5
    var operation: UINavigationController.Operation = .none
    private let zoomScale = CGFloat(15)
    private let backgroundScale = CGFloat(0.7)
    
    typealias ZoomingView = (otherView: UIView, imageView: UIView)
    
    func configureViews(for state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, viewsInBackground: ZoomingView, viewsInForeground: ZoomingView, snapshotViews: ZoomingView) {
        
        switch state {
        case .inital:
//            backgroundViewController.view.transform = CGAffineTransform.identity
            backgroundViewController.view.alpha = 1.0
            
            snapshotViews.imageView.frame = containerView.convert(viewsInBackground.imageView.frame, from: viewsInBackground.imageView.superview)
        case .final:
//            backgroundViewController.view.transform = CGAffineTransform(scaleX: backgroundScale, y: backgroundScale)
            backgroundViewController.view.alpha = 0.0
            
            snapshotViews.imageView.frame = containerView.convert(viewsInForeground.imageView.frame, from: viewsInForeground.imageView.superview)
        }
    }
}

extension ZoomTransitioningDelegate: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        
        var backgroundViewController = fromViewController
        var foregroundViewController = toViewController
        
        if operation == .pop {
            backgroundViewController = toViewController
            foregroundViewController = fromViewController
        }
        
        let maybeBackgroundImageView = (backgroundViewController as? ZoomingViewController)?.zoomingImageView(for: self)
        let maybeForegroundImageView = (foregroundViewController as? ZoomingViewController)?.zoomingImageView(for: self)
        
        assert(maybeBackgroundImageView != nil, "Cannot find image in backgroundVC")
        assert(maybeForegroundImageView != nil, "Cannot find image in foregroundVC")
        
        let backgroundImageView = maybeBackgroundImageView!
        let foregroundImageView = maybeForegroundImageView!
        
        let imageViewSnapshot = UIImageView(image: backgroundImageView.image)
        imageViewSnapshot.contentMode = .scaleAspectFill
        imageViewSnapshot.layer.masksToBounds = true
        
        backgroundImageView.isHidden = true
        foregroundImageView.isHidden = true
        
        let foregroundViewBackgroundColor = foregroundViewController.view.backgroundColor
        foregroundViewController.view.backgroundColor = .clear
        containerView.backgroundColor = .white
        
        containerView.addSubview(backgroundViewController.view)
        containerView.addSubview(foregroundViewController.view)
        containerView.addSubview(imageViewSnapshot)
        
        var preTransitionState = TransitionState.inital
        var postTransitionState = TransitionState.final
        
        if operation == .pop {
            preTransitionState =  .final
            postTransitionState = .inital
        }
        
        self.configureViews(for: preTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundImageView, backgroundImageView), viewsInForeground: (foregroundImageView, foregroundImageView), snapshotViews: (imageViewSnapshot, imageViewSnapshot))
        
        foregroundViewController.view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            
            self.configureViews(for: postTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundImageView, backgroundImageView), viewsInForeground: (foregroundImageView, foregroundImageView), snapshotViews: (imageViewSnapshot, imageViewSnapshot))
        }) { (finished) in
            
            backgroundImageView.transform = CGAffineTransform.identity
            imageViewSnapshot.removeFromSuperview()
            backgroundImageView.isHidden = false
            foregroundImageView.isHidden = false
            foregroundViewController.view.backgroundColor = foregroundViewBackgroundColor
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}

extension ZoomTransitioningDelegate: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is ZoomingViewController && toVC is ZoomingViewController {
            self.operation = operation
            return self
        } else {
            return nil
        }
    }
}

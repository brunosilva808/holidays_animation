//
//  ZoomTransitioningDelegate.swift
//  Hollidays Animations
//
//  Created by Carbon on 08/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

protocol ZoomingViewController {
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView?
    func zoomingShadowView(for transition: ZoomTransitioningDelegate) -> UIView?
    func zoomingBackgroundImageView(for transition: ZoomTransitioningDelegate) -> UIView?
}

extension ZoomingViewController {
    func zoomingShadowView(for transition: ZoomTransitioningDelegate) -> UIView? { return nil }
}

enum TransitionState {
    
    case initial
    case final
}

class ZoomTransitioningDelegate: NSObject {
    
    var transitionDuration = 0.5
    var operation: UINavigationController.Operation = .none
    var isPresenting: Bool = false
    private let backgroundScale = CGFloat(0.7)
    
    typealias ZoomingViews = (otherView: UIView, imageView: UIView)
    
    func configureViews(for state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews)
    {
        switch state {
        case .initial:
            backgroundViewController.view.transform = CGAffineTransform.identity
            backgroundViewController.view.alpha = 1
            
            snapshotViews.imageView.frame = containerView.convert(viewsInBackground.imageView.frame, from: viewsInBackground.imageView.superview)
            snapshotViews.otherView.frame = containerView.convert(viewsInBackground.otherView.frame, from: viewsInBackground.otherView.superview)
            
        case .final:
            backgroundViewController.view.transform = CGAffineTransform(scaleX: backgroundScale, y: backgroundScale)
            backgroundViewController.view.alpha = 0
            
            snapshotViews.imageView.frame = containerView.convert(viewsInForeground.imageView.frame, from: viewsInForeground.imageView.superview)
            snapshotViews.imageView.frame = containerView.convert(viewsInForeground.otherView.frame, from: viewsInForeground.otherView.superview)
        }
    }
}

extension ZoomTransitioningDelegate: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        let backgroundViewController = isPresenting ? fromViewController : toViewController
        let foregroundViewController = isPresenting ? toViewController : fromViewController
        
        guard let backgroundImageView = (backgroundViewController as? ZoomingViewController)?.zoomingImageView(for: self) else { return }
        guard let backgroundShadowView = (backgroundViewController as? ZoomingViewController)?.zoomingShadowView(for: self) else { return }
        guard let foregroundImageView = (foregroundViewController as? ZoomingViewController)?.zoomingImageView(for: self) else { return }
        guard let foregroundDetailView = (foregroundViewController as? ZoomingViewController)?.zoomingBackgroundImageView(for: self) else { return }
        
        let imageViewSnapshot = UIImageView(image: backgroundImageView.image)
        imageViewSnapshot.contentMode = .scaleAspectFill
        imageViewSnapshot.layer.masksToBounds = true
        imageViewSnapshot.setRoundedCorners(toRadius: 15)
        
        let shadowViewSnapshot = UIView(frame: backgroundShadowView.frame)
        shadowViewSnapshot.backgroundColor = .white
        shadowViewSnapshot.setRoundedCorners(toRadius: 15)
        shadowViewSnapshot.setShadow(color: .black, radius: 5)
        
        backgroundShadowView.isHidden = true
        backgroundImageView.isHidden = true
        foregroundImageView.isHidden = true
        foregroundDetailView.isHidden = true
        
        let containerView = transitionContext.containerView
        containerView.addSubview(backgroundViewController.view)
        containerView.addSubview(foregroundViewController.view)
        containerView.addSubview(shadowViewSnapshot)
        containerView.addSubview(imageViewSnapshot)
        
        let detailViewSnapshot = UIView(frame: foregroundDetailView.frame)
        detailViewSnapshot.backgroundColor = .red
        detailViewSnapshot.setRoundedCorners(toRadius: 15)
        detailViewSnapshot.frame = isPresenting ?
            CGRect(x: 0,
                   y: UIScreen.main.bounds.height,
                   width: UIScreen.main.bounds.width,
                   height: 0) :
            CGRect(x: 0,
                   y: UIScreen.main.bounds.height - foregroundDetailView.frame.height,
                   width: UIScreen.main.bounds.width,
                   height: 0)
        detailViewSnapshot.layer.masksToBounds = true
        containerView.addSubview(detailViewSnapshot)
        
        let preTransitionState = isPresenting ? TransitionState.initial : TransitionState.final
        let postTransitionState = isPresenting ? TransitionState.final : TransitionState.initial
        
        configureViews(for: preTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundImageView, backgroundImageView), viewsInForeground: (foregroundImageView, foregroundImageView), snapshotViews: (shadowViewSnapshot, imageViewSnapshot))
        
        foregroundViewController.view.layoutIfNeeded()
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            
            self.configureViews(for: postTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundImageView, backgroundImageView), viewsInForeground: (foregroundImageView, foregroundImageView), snapshotViews: (shadowViewSnapshot, imageViewSnapshot))
            
            detailViewSnapshot.frame = self.isPresenting ?
                CGRect(x: 0,
                       y: UIScreen.main.bounds.height - foregroundDetailView.frame.height + DetailViewController.detailViewMargin,
                       width: UIScreen.main.bounds.width,
                       height: foregroundDetailView.frame.height + DetailViewController.detailViewMargin) :
                CGRect(x: 0,
                       y: UIScreen.main.bounds.height,
                       width: UIScreen.main.bounds.width,
                       height: foregroundDetailView.frame.height)
            
        }) { (finished) in
            
            backgroundViewController.view.transform = CGAffineTransform.identity
            imageViewSnapshot.removeFromSuperview()
            detailViewSnapshot.removeFromSuperview()
            shadowViewSnapshot.removeFromSuperview()
            backgroundShadowView.isHidden = false
            backgroundImageView.isHidden = false
            foregroundImageView.isHidden = false
            foregroundDetailView.isHidden = false
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}

extension ZoomTransitioningDelegate: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is ZoomingViewController && toVC is ZoomingViewController {
            if operation == .push {
                self.isPresenting = true
            } else {
                self.isPresenting = false
            }
            
            return self
        } else {
            return nil
        }
    }
}

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
    func zoomingTitleLabel(for transition: ZoomTransitioningDelegate) -> UILabel?
    func zoomingDetailView(for transition: ZoomTransitioningDelegate) -> UIView?
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
    var model: Holiday?
    
    typealias ZoomingViews = (otherView: UIView, imageView: UIView, label: UILabel)
    
    init(holiday: Holiday) {
        super.init()
        
        self.model = holiday
    }
    
    func configureViews(for state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews)
    {
        switch state {
        case .initial:
            backgroundViewController.view.transform = CGAffineTransform.identity
            backgroundViewController.view.alpha = 1
            
            snapshotViews.imageView.frame = containerView.convert(viewsInBackground.imageView.frame, from: viewsInBackground.imageView.superview)
            snapshotViews.label.frame = containerView.convert(viewsInForeground.label.frame, from: viewsInForeground.label.superview)
        case .final:
            backgroundViewController.view.transform = CGAffineTransform(scaleX: backgroundScale, y: backgroundScale)
            backgroundViewController.view.alpha = 0
            
            snapshotViews.imageView.frame = containerView.convert(viewsInForeground.imageView.frame, from: viewsInForeground.imageView.superview)
            snapshotViews.label.frame = containerView.convert(viewsInBackground.label.frame, from: viewsInBackground.label.superview)
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
        guard let foregroundImageView = (foregroundViewController as? ZoomingViewController)?.zoomingImageView(for: self) else { return }
        guard let backgroundLabelTitle = (backgroundViewController as? ZoomingViewController)?.zoomingTitleLabel(for: self) else { return }
        guard let foregroundLabelTitle = (foregroundViewController as? ZoomingViewController)?.zoomingTitleLabel(for: self) else { return }
        guard let foregroundDetailView = (foregroundViewController as? ZoomingViewController)?.zoomingDetailView(for: self) else { return }
        
        backgroundImageView.isHidden = true
        foregroundImageView.isHidden = true
        backgroundLabelTitle.isHidden = true
        foregroundLabelTitle.isHidden = true
        foregroundDetailView.isHidden = true
        
        let imageViewSnapshot = UIImageView(image: backgroundImageView.image)
        imageViewSnapshot.contentMode = .scaleAspectFill
        imageViewSnapshot.layer.masksToBounds = true
        imageViewSnapshot.setRoundedCorners(toRadius: 15)

        let labelSnapshot = UILabel(frame: backgroundLabelTitle.frame)
        labelSnapshot.textColor = .white
        labelSnapshot.font = UIFont.boldSystemFont(ofSize: 21)
        labelSnapshot.text = self.model?.title
        
        let detailViewSnapshot = UIView(frame: foregroundDetailView.frame)
        detailViewSnapshot.backgroundColor = .white
        detailViewSnapshot.layer.masksToBounds = true
        detailViewSnapshot.setRoundedCorners(toRadius: 15)
        detailViewSnapshot.frame = isPresenting ?
            CGRect(x: 0,
                   y: UIScreen.main.bounds.height,
                   width: UIScreen.main.bounds.width,
                   height: DetailViewController.detailViewHeight) :
            CGRect(x: 0,
                   y: UIScreen.main.bounds.height - foregroundDetailView.frame.height,
                   width: UIScreen.main.bounds.width,
                   height: DetailViewController.detailViewHeight)
        
        let containerView = transitionContext.containerView
        containerView.addSubview(backgroundViewController.view)
        containerView.addSubview(foregroundViewController.view)
        containerView.addSubview(imageViewSnapshot)
        containerView.addSubview(labelSnapshot)
        containerView.addSubview(detailViewSnapshot)
        
        let preTransitionState = isPresenting ? TransitionState.initial : TransitionState.final
        let postTransitionState = isPresenting ? TransitionState.final : TransitionState.initial
        
        configureViews(for: preTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundImageView, backgroundImageView, backgroundLabelTitle), viewsInForeground: (foregroundImageView, foregroundImageView, foregroundLabelTitle), snapshotViews: (imageViewSnapshot, imageViewSnapshot, labelSnapshot))
        
        foregroundViewController.view.layoutIfNeeded()
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            
            self.configureViews(for: postTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundImageView, backgroundImageView, backgroundLabelTitle), viewsInForeground: (foregroundImageView, foregroundImageView, foregroundLabelTitle), snapshotViews: (imageViewSnapshot, imageViewSnapshot, labelSnapshot))
            
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
            labelSnapshot.removeFromSuperview()
            detailViewSnapshot.removeFromSuperview()
            
            backgroundImageView.isHidden = false
            foregroundImageView.isHidden = false
            foregroundLabelTitle.isHidden = false
            backgroundLabelTitle.isHidden = false
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

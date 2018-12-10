//
//  CustomAnimator.swift
//  Hollidays Animations
//
//  Created by Carbon on 10/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

class CustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: TimeInterval
    var isPresenting: Bool
    var originFrame: CGRect
    var image: UIImage
    var detailFrame: CGRect
    var detailView: UIView
    var originFrame2: CGRect
    var image2: UIImage
    public let DetailAnimatorTag = 98
    public let CustomAnimatorTag = 99
    
    init(duration: TimeInterval, isPresenting: Bool, originFrame: CGRect, image: UIImage, detailFrame: CGRect, detailView: UIView) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.image = image
        self.detailFrame = detailFrame
        self.detailView = detailView
        self.originFrame2 = originFrame
        self.image2 = image
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
     
        self.isPresenting ? containerView.addSubview(toView) : containerView.insertSubview(toView, aboveSubview: fromView)
        
        let presentingView = isPresenting ? toView : fromView
        guard let artwork = presentingView.viewWithTag(CustomAnimatorTag) as? UIImageView else { return }
        artwork.image = image
        artwork.alpha = 0
        
        let transitionImageView = UIImageView(frame: isPresenting ? originFrame : artwork.frame)
        transitionImageView.image = image
        containerView.addSubview(transitionImageView)
        
        guard let artwork2 = presentingView.viewWithTag(DetailAnimatorTag) as? UIImageView else { return }
        artwork2.image = image2
        artwork2.alpha = 0
        
        let transitionImageView2 = UIImageView(frame: isPresenting ? CGRect(x: 0, y: UIScreen.main.bounds.height+244, width: UIScreen.main.bounds.width, height: 244) : artwork2.frame)
        transitionImageView2.image = image2
        containerView.addSubview(transitionImageView2)
        
        toView.frame = isPresenting ?  CGRect(x: 0, y: toView.frame.height, width: toView.frame.width, height: toView.frame.height) : toView.frame
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            
            transitionImageView2.frame = self.isPresenting ? artwork2.frame : self.originFrame
            transitionImageView.frame = self.isPresenting ? artwork.frame : self.originFrame2
            presentingView.frame = self.isPresenting ? fromView.frame : CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            presentingView.alpha = self.isPresenting ? 1 : 0
        }, completion: { (finished) in
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionImageView2.removeFromSuperview()
            transitionImageView.removeFromSuperview()
            artwork2.alpha = 1
            artwork.alpha = 1
        })
    }
    

}

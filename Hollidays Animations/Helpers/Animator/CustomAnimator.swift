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
    public let CustomAnimatorTag = 99
    
    init(duration : TimeInterval, isPresenting : Bool, originFrame : CGRect, image : UIImage) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.image = image
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
     
        self.isPresenting ? containerView.addSubview(toView) : containerView.insertSubview(toView, aboveSubview: fromView)
        
        let detailView = isPresenting ? toView : fromView
        guard let artwork = detailView.viewWithTag(CustomAnimatorTag) as? UIImageView else { return }
        artwork.image = image
        artwork.alpha = 0
        
        let transitionImageView = UIImageView(frame: isPresenting ? originFrame : artwork.frame)
        transitionImageView.image = image
        containerView.addSubview(transitionImageView)
        
        toView.frame = isPresenting ?  CGRect(x: 0, y: toView.frame.height, width: toView.frame.width, height: toView.frame.height) : toView.frame
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            
            transitionImageView.frame = self.isPresenting ? artwork.frame : self.originFrame
            detailView.frame = self.isPresenting ? fromView.frame : CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            detailView.alpha = self.isPresenting ? 1 : 0
        }, completion: { (finished) in
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionImageView.removeFromSuperview()
            artwork.alpha = 1
        })
    }
    

}

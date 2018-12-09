//
//  CollectionFlowLayout.swift
//  Hollidays Animations
//
//  Created by Bruno Silva on 06/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

class SpringyFlowLayout: UICollectionViewFlowLayout {
    
    var dynamicAnimator: UIDynamicAnimator?
    
    override func prepare() {
        super.prepare()
        
        if self.dynamicAnimator == nil {
            self.dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
            
            let contentSize = self.collectionViewContentSize
            if let items = super.layoutAttributesForElements(in: CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)) {
                items.forEach {
                    let spring = UIAttachmentBehavior.init(item: $0, attachedToAnchor: $0.center)
                    spring.length = 0
                    spring.damping = 0.5
                    spring.frequency = 0.8
                    
                    self.dynamicAnimator?.addBehavior(spring)
                }
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.dynamicAnimator?.items(in: rect) as? [UICollectionViewLayoutAttributes]
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.dynamicAnimator?.layoutAttributesForCell(at: indexPath)
    }
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let scrollView = self.collectionView else { return false }
        let touchLocation = scrollView.panGestureRecognizer.location(in: scrollView)
        let scrollDelta = newBounds.origin.y + scrollView.bounds.origin.y
    
        self.dynamicAnimator?.behaviors.forEach {
            guard let behavior = $0 as? UIAttachmentBehavior, let item = behavior.items.first else { return }
            
            let anchorPoint = behavior.anchorPoint
            let distanceFromTouch = touchLocation.y + anchorPoint.y
            let scrollResistance = distanceFromTouch / 25
            
            var center = item.center
            center.y += min(scrollDelta, scrollResistance)
            item.center = center
            
            self.dynamicAnimator?.updateItem(usingCurrentState: item)
        }
        
        return false
    }
    
}

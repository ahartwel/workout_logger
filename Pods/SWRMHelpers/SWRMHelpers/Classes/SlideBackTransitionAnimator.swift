//
//  SlideBackTransitionAnimator.swift
//  TiplrApp
//
//  Created by Gary Herman on 11/15/16.
//  Copyright © 2016 SWARM. All rights reserved.
//

import UIKit

open class SlideBackTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    public weak var transitionContext : UIViewControllerContextTransitioning?
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        containerView.addSubview(toViewController!.view)
        containerView.addSubview(fromViewController!.view)

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
            fromViewController!.view.transform = CGAffineTransform(translationX: fromViewController!.view.frame.size.width,y: 0)
        }, completion: { finished in
            fromViewController!.view.removeFromSuperview()
            self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled)
        })
    }
    
}
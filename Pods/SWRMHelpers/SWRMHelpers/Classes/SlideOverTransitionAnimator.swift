//
//  SlideOverTransitionAnimator.swift
//  TiplrApp
//
//  Created by Gary Herman on 11/15/16.
//  Copyright © 2016 SWARM. All rights reserved.
//

import UIKit

open class SlideOverTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
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
        
        toViewController!.view.transform = CGAffineTransform(translationX: toViewController!.view.frame.size.width,y: 0)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
            toViewController!.view.transform = CGAffineTransform.identity
        }, completion: { finished in
            self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled)
        })
    }
    
}

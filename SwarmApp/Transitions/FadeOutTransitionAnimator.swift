//
//  FadeOutTransitionAnimator.swift
//  TiplrApp
//
//  Created by Gary on 3/2/16.
//  Copyright © 2016 Gary. All rights reserved.
//

import UIKit

class FadeOutTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var transitionContext : UIViewControllerContextTransitioning?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) //as! UIViewController
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) //as! UIViewController
        
        let fromCopy = fromViewController!.view.snapshotView(afterScreenUpdates: true)
        fromCopy!.frame = fromViewController!.view.frame
        toViewController!.view.alpha = 0
        containerView.addSubview(toViewController!.view)
        containerView.addSubview(fromCopy!)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
            fromCopy!.alpha = 0
            toViewController!.view.alpha = 1
            }, completion: { finished in
                fromCopy!.removeFromSuperview()
                self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled)
        })
    }
}

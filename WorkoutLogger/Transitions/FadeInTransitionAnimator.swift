//
//  FadeInTransitionAnimator.swift
//  TiplrApp
//
//  Created by Gary on 3/2/16.
//  Copyright © 2016 Gary. All rights reserved.
//

import UIKit

class FadeInTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var transitionContext : UIViewControllerContextTransitioning?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) //as! CBSViewController
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) //as! CBSViewController
        
        let fromCopy = fromViewController!.view.snapshotView(afterScreenUpdates: true)
        fromCopy!.frame = fromViewController!.view.frame
        containerView.addSubview(fromCopy!)
        containerView.addSubview(toViewController!.view)
        
        toViewController!.view.alpha = 0
                
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
            toViewController!.view.alpha = 1
            }, completion: { finished in
                self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled)
        })
    }
}

//
//  NavigationControllerDelegate.swift
//  TiplrApp
//
//  Created by Gary on 2/12/16.
//  Copyright © 2016 Gary. All rights reserved.
//

import UIKit

open class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .pop {
            return PopTransitionAnimator()
        } else if operation == .push {
            return PushTransitionAnimator()
        }

        return PushTransitionAnimator()
    }
    
    public func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return .portrait
    }
    
}

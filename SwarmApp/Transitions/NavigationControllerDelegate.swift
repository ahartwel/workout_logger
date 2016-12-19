//
//  NavigationControllerDelegate.swift
//  TiplrApp
//
//  Created by Gary on 2/12/16.
//  Copyright © 2016 Gary. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .pop {
            return PopTransitionAnimator()
        } else if operation == .push {
            return PushTransitionAnimator()
        }

        return PushTransitionAnimator()
    }
    
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return .portrait
    }
    
}

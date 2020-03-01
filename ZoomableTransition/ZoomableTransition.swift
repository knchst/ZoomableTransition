//
//  ZoomableTransition.swift
//  ZoomableTransition
//
//  Created by Kenichi Saito on 12/16/19.
//  Copyright © 2019 Kenichi Saito. All rights reserved.
//

import UIKit

public class ZoomableTransition: NSObject {
    public override init() {
        super.init()
    }
}

extension ZoomableTransition: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

    }

//    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return zoomInteractiveTransition.interactionController
//    }

    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        if let source = fromVC as? ZoomableTransitionSource, let target = toVC as? ZoomableTransitionTarget, operation == .push {
            return ZoomableAnimatedTransitioning(source: source, target: target, isPush: true)
        } else if let source = toVC as? ZoomableTransitionSource, let target = fromVC as? ZoomableTransitionTarget, operation == .pop {
            return ZoomableAnimatedTransitioning(source: source, target: target, isPush: false)
        }
        return nil
    }
}

//
//  ZoomableInteractiveTransition.swift
//  ZoomableTransition
//
//  Created by Kenichi Saito on 2020/03/15.
//  Copyright © 2020 Kenichi Saito. All rights reserved.
//

import UIKit

class ZoomableInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var navigationController : UINavigationController
    var shouldCompleteTransition = false
    var transitionInProgress = false

    init?(attachTo viewController: UIViewController) {
        if let nav = viewController.navigationController {
            self.navigationController = nav
            super.init()
            let swipeBackGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleBackGesture(_:)))
            swipeBackGesture.edges = .left
            viewController.view.addGestureRecognizer(swipeBackGesture)
        } else {
            return nil
        }
    }
    
    @objc private func handleBackGesture(_ gesture : UIScreenEdgePanGestureRecognizer) {
        let viewTranslation = gesture.translation(in: gesture.view?.superview)
        let progress = viewTranslation.x / self.navigationController.view.frame.width

        switch gesture.state {
        case .began:
            transitionInProgress = true
            navigationController.popViewController(animated: true)
            break
        case .changed:
            shouldCompleteTransition = progress > 0.25
            update(progress)
            break
        case .cancelled:
            transitionInProgress = false
            cancel()
            break
        case .ended:
            transitionInProgress = false
            shouldCompleteTransition ? finish() : cancel()
            break
        default:
            return
        }
    }
    
}

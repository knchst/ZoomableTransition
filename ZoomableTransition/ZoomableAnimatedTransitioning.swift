//
//  ZoomableAnimatedTransitioning.swift
//  ZoomableTransition
//
//  Created by Kenichi Saito on 12/16/19.
//  Copyright © 2019 Kenichi Saito. All rights reserved.
//

import UIKit

class ZoomableAnimatedTransitioning: NSObject {
    var isPush: Bool
    var source: ZoomableTransitionSource?
    var target: ZoomableTransitionTarget?

    init(source: ZoomableTransitionSource, target: ZoomableTransitionTarget, isPush: Bool) {
        self.isPush = isPush
        self.source = source
        self.target = target
    }
}

extension ZoomableAnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPush {
            animateTransitionForPush(transitionContext)
        } else {
            animateTransitionForPop(transitionContext)
        }
    }
}

extension ZoomableAnimatedTransitioning {
    private func animateTransitionForPush(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        guard let transitionSourceView: UIView = source?.zoomableSourceView() else { return }
        guard let transitionTargetView: UIView = target?.zoomableTargetView() else { return }
        let containerView = transitionContext.containerView

        toVC.view.alpha = 0
        containerView.addSubview(toVC.view)
        containerView.addSubview(transitionSourceView)
        containerView.bringSubviewToFront(transitionSourceView)

        source?.zoomableSourceTransitionWillBegin(targetView: transitionTargetView)
        target?

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                transitionSourceView.frame = transitionTargetView.frame
                toVC.view.alpha = 1
            }, completion: { completed in
                transitionSourceView.removeFromSuperview()

                let completed: Bool = !transitionContext.transitionWasCancelled
                transitionContext.completeTransition(completed)
            })
        }
    }

    private func animateTransitionForPop(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        guard let transitionSourceView: UIView = source?.zoomableSourceView() else { return }
        guard let transitionTargetView: UIView = target?.zoomableTargetView() else { return }
        let containerView = transitionContext.containerView

        toVC.view.alpha = 0
        containerView.addSubview(toVC.view)
        containerView.addSubview(transitionTargetView)
        containerView.bringSubviewToFront(transitionTargetView)

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseInOut, animations: {
                transitionTargetView.frame = transitionSourceView.frame
                toVC.view.alpha = 1
            }, completion: { completed in
                transitionTargetView.removeFromSuperview()

                let completed = !transitionContext.transitionWasCancelled
                transitionContext.completeTransition(completed)
            })
        }
    }
}

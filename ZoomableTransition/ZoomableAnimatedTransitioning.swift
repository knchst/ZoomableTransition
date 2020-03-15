//
//  ZoomableAnimatedTransitioning.swift
//  ZoomableTransition
//
//  Created by Kenichi Saito on 12/16/19.
//  Copyright © 2019 Kenichi Saito. All rights reserved.
//

import UIKit

class ZoomableAnimatedTransitioning: NSObject {
    enum TransitionType {
        case push
        case pop
    }
    var type: TransitionType
    var source: ZoomableTransitionSource?
    var target: ZoomableTransitionTarget?

    init(source: ZoomableTransitionSource, target: ZoomableTransitionTarget, type: TransitionType) {
        self.type = type
        self.source = source
        self.target = target
    }
}

extension ZoomableAnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if type == .push {
            return 0.25
        } else {
            return 0.30
        }
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if type == .push {
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
        guard let transitionSourceViewFrame: CGRect = source?.zoomableSourceViewFrame() else { return }
        guard let transitionTargetView: UIView = target?.zoomableTargetView() else { return }
        guard let transitionTargetViewFrame: CGRect = target?.zoomableTargetViewFrame() else { return }
        let containerView = transitionContext.containerView

        toVC.view.alpha = 0
        containerView.addSubview(toVC.view)
        containerView.addSubview(transitionSourceView)
        containerView.bringSubviewToFront(transitionSourceView)

        source?.zoomableSourceTransitionWillBegin(targetView: transitionTargetView)
        target?.zoomableTargetTransitionWillBegin(sourceView: transitionSourceView)

        DispatchQueue.main.async {
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
                transitionSourceView.frame = transitionTargetViewFrame
                toVC.view.alpha = 1
            }, completion: { completed in
                transitionSourceView.removeFromSuperview()
                self.source?.zoomableSourceTransitionDidEnd(targetView: transitionTargetView)
                self.target?.zoomableTargetTransitionDidEnd(sourceView: transitionSourceView)
                let completed: Bool = !transitionContext.transitionWasCancelled
                transitionContext.completeTransition(completed)
            })
        }
    }

    private func animateTransitionForPop(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return }
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let transitionSourceView: UIView = source?.zoomableSourceView() else { return }
        guard let transitionSourceViewFrame: CGRect = source?.zoomableSourceViewFrame() else { return }
        guard let transitionTargetView: UIView = target?.zoomableTargetView() else { return }
        guard let transitionTargetViewFrame: CGRect = target?.zoomableTargetViewFrame() else { return }
        let containerView = transitionContext.containerView
        
        let transitionView: UIView = NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: transitionTargetView)) as! UIView
        transitionView.translatesAutoresizingMaskIntoConstraints = true
        transitionView.frame = transitionTargetViewFrame
        containerView.backgroundColor = fromView.backgroundColor
        fromView.alpha = 1
        toView.alpha = 0

        containerView.insertSubview(toView, belowSubview: fromView)
        containerView.addSubview(transitionView)
        containerView.layoutIfNeeded()
        DispatchQueue.main.async {
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
                fromView.alpha = 0
                toView.alpha = 1
                transitionView.frame = transitionSourceViewFrame
            }, completion: { completed in
                fromView.alpha = 1
                transitionView.alpha = 0
                transitionView.removeFromSuperview()
                let completed = !transitionContext.transitionWasCancelled
                transitionContext.completeTransition(completed)
            })
        }
    }
}

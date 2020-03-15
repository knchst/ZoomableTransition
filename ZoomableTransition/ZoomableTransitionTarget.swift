//
//  ZoomableTransitionTarget.swift
//  ZoomableTransition
//
//  Created by Kenichi Saito on 12/15/19.
//  Copyright © 2019 Kenichi Saito. All rights reserved.
//

import UIKit

public protocol ZoomableTransitionTarget {
    func zoomableTargetView() -> UIView
    func zoomableTargetViewFrame() -> CGRect
    func zoomableTargetTransitionWillBegin(sourceView: UIView)
    func zoomableTargetTransitionDidEnd(sourceView: UIView)
    func zoomableTargetTransitionDidCancel(sourceView: UIView)
}

extension ZoomableTransitionTarget {
    func zoomableTargetTransitionWillBegin(sourceView: UIView) { }
    func zoomableTargetTransitionDidEnd(sourceView: UIView) { }
    func zoomableTargetTransitionDidCancel(sourceView: UIView) { }
}

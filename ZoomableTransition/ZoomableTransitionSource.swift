//
//  ZoomableTransitionSource.swift
//  ZoomableTransition
//
//  Created by Kenichi Saito on 12/15/19.
//  Copyright © 2019 Kenichi Saito. All rights reserved.
//

import UIKit

public protocol ZoomableTransitionSource {
    func zoomableSourceView() -> UIView
    func zoomableSourceViewFrame() -> CGRect
    func zoomableSourceTransitionWillBegin(targetView: UIView)
    func zoomableSourceTransitionDidEnd(targetView: UIView)
    func zoomableSourceTransitionDidCancel(targetView: UIView)
}

extension ZoomableTransitionSource {
    func zoomableSourceTransitionWillBegin(targetView: UIView) { }
    func zoomableSourceTransitionDidEnd(targetView: UIView) { }
    func zoomableSourceTransitionDidCancel(targetView: UIView) { }
}

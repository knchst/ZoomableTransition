//
//  ImageViewController.swift
//  Example
//
//  Created by Kenichi Saito on 12/16/19.
//  Copyright © 2019 Kenichi Saito. All rights reserved.
//

import UIKit
import ZoomableTransition

class ImageViewController: UIViewController {

    var image: UIImage!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ImageViewController: ZoomableTransitionTarget {
    var targetTransitioningDuration: TimeInterval {
        return 0.3
    }
    
    func zoomableTargetView() -> UIView {
        return imageView
    }
    
    func zoomableTargetViewFrame() -> CGRect {
        view.layoutIfNeeded()
        var frame = self.imageView.frame
        frame.origin.y = self.navigationController!.navigationBar.frame.height + UIApplication.shared.statusBarFrame.height
        return frame
    }
    
    func zoomableTargetTransitionWillBegin(sourceView: UIView) {
        imageView.isHidden = true
    }
    
    func zoomableTargetTransitionDidEnd(sourceView: UIView) {
        imageView.isHidden = false
    }
    
    func zoomableTargetTransitionDidCancel(sourceView: UIView) {
    }
}

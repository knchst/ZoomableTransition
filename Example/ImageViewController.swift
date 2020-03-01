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
    func transitionTargetView() -> UIView {
        view.layoutIfNeeded()
        let imageView = UIImageView(image: self.imageView.image)
        var frame = self.imageView.frame
        frame.origin.y = self.navigationController!.navigationBar.frame.height + UIApplication.shared.statusBarFrame.height
        imageView.frame = frame
        return imageView
    }
}

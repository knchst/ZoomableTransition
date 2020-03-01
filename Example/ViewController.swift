//
//  ViewController.swift
//  Example
//
//  Created by Kenichi Saito on 12/15/19.
//  Copyrigbht © 2019 Kenichi Saito. All rights reserved.
//

import UIKit
import ZoomableTransition

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var images: [String] = []

    var selectedIndexPath: IndexPath?

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        for idx in 0...17 {
            images.append("\(idx)")
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let layout = UICollectionViewFlowLayout()
        let gridWidth = (collectionView.frame.size.width - 2) / 3
        layout.itemSize = CGSize(width: gridWidth, height: gridWidth)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView.setCollectionViewLayout(layout, animated: false)

        collectionView.reloadData()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = UIImage(named: "\(images[indexPath.item]).jpg")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "ImageViewController", bundle: nil).instantiateInitialViewController() as? ImageViewController else { return }
        vc.image = UIImage(named: "\(images[indexPath.item]).jpg")
        selectedIndexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: ZoomableTransitionSource {
    func transitionSourceView() -> UIView {
        guard let indexPath = selectedIndexPath,
            let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return UIView() }
        let imageView = UIImageView(image: cell.imageView.image)
        let cellFrame = collectionView.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
        imageView.frame = collectionView.convert(cellFrame, to: view)
        return imageView
    }
}

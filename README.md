# ZoomableTransition

A custom zoom transition for UINavigationController.

<img src="https://raw.githubusercontent.com/knchst/ZoomableTransition/master/demo.gif" width="375">


### Installation:

CocoaPods

```ruby
pod 'ZoomableTransition'
```

### Usage

ZoomableTransiiton has two important protocols. To apply transiton for your UINavigationController when you must adapt source viewcontroller 

To apply the transition to your UINavigationController, source viewcontroller must conform to `ZoomableTransitionSource` and target viewcontroller must conform to ZoomableTransitionTarget.

**1. ZoomableTransitionSource**

```swift
extension ViewController: ZoomableTransitionSource {
    var sourceView: UIImageView? {
        guard let indexPath = selectedIndexPath,
            let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return nil }
        let cellFrame = collectionView.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
        let imageView = UIImageView(image: cell.imageView.image)
        imageView.frame = collectionView.convert(cellFrame, to: view)
        return imageView
    }
    
    func zoomableSourceView() -> UIView {
        guard let sourceView = sourceView else { return UIView() }
        return sourceView
    }
    
    func zoomableSourceViewFrame() -> CGRect {
        guard let indexPath = selectedIndexPath else { return .zero }
        let cellFrame = collectionView.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
        return collectionView.convert(cellFrame, to: view)
    }
    
    func zoomableSourceTransitionWillBegin(targetView: UIView) {
        sourceView?.isHidden = true
    }
    
    func zoomableSourceTransitionDidEnd(targetView: UIView) {
        sourceView?.isHidden = false
    }
    
    func zoomableSourceTransitionDidCancel(targetView: UIView) {
        sourceView?.isHidden = false
    }
}
```

**2. ZoomableTransitionTarget**

```swift
extension ImageViewController: ZoomableTransitionTarget {
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
    
    func zoomableTargetTransitionDidCancel(sourceView: UIView) { }
}
```

### Author

Kenichi Saito / knchst@icloud.com / [@knchst0704](https://www.twitter.com/knchst0704)

### License

ZoomableTransition is available under the MIT license. See the LICENSE file for more info.

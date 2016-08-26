import UIKit
import Photos
import Cartography

class GridView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

  var items: [PHAsset] = []

  // MARK: - Initialization

  lazy var topView: UIView = self.makeTopView()
  lazy var bottomView: UIView = self.makeBottomView()
  lazy var titleView: TitleView = self.makeTitleView()
  lazy var collectionView: UICollectionView = self.makeCollectionView()
  lazy var closeButton: UIButton = self.makeCloseButton()
  lazy var doneButton: UIButton = self.makeDoneButton()

  // MARK: - Setup

  func setup() {
    [topView, collectionView, bottomView].forEach {
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    [closeButton, titleView].forEach {
      self.topView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    [doneButton].forEach {
      self.bottomView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    constrain(topView, collectionView, bottomView) {
      topView, collectionView, bottomView in

      topView.left == topView.superview!.left
      topView.top == topView.superview!.top
      topView.right == topView.superview!.right
      topView.height == 40

      collectionView.top == topView.bottom + 1
      collectionView.left == collectionView.superview!.left
      collectionView.right == collectionView.superview!.right
      collectionView.bottom == collectionView.superview!.bottom

      bottomView.left == bottomView.superview!.left
      bottomView.right == bottomView.superview!.right
      bottomView.bottom == bottomView.superview!.bottom
      bottomView.height == 80
    }

    constrain(closeButton, titleView) {
      closeButton, titleView in

      closeButton.top == closeButton.superview!.top
      closeButton.left == closeButton.superview!.left
      closeButton.width == 40
      closeButton.height == 40

      titleView.center == titleView.superview!.center
      titleView.height == 40
    }

    constrain(doneButton) {
      doneButton in

      doneButton.centerY == doneButton.superview!.centerY
      doneButton.right == doneButton.superview!.right - 38
    }
  }

  // MARK: - Controls

  func makeTopView() -> UIView {
    let view = UIView()
    view.backgroundColor = UIColor.whiteColor()

    return view
  }

  func makeBottomView() -> UIView {
    let view = UIView()
    view.backgroundColor = Config.BottomContainer.backgroundColor

    return view
  }

  func makeTitleView() -> TitleView {
    let view = TitleView()

    return view
  }

  func makeGridView() -> GridView {
    let view = GridView()

    return view
  }

  func makeCloseButton() -> UIButton {
    let button = UIButton(type: .Custom)
    button.setImage(BundleAsset.image("gallery_close"), forState: .Normal)

    return button
  }

  func makeDoneButton() -> UIButton {
    let button = UIButton(type: .System)
    button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    button.titleLabel?.font = UIFont.systemFontOfSize(16)
    button.setTitle("Done", forState: .Normal)
    
    return button
  }

  func makeCollectionView() -> UICollectionView {
    let view = UICollectionView()
    view.dataSource = self
    view.delegate = self

    return view
  }

  // MARK: - UICollectionViewDataSource

  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    fatalError()
  }

  // MARK: - UICollectionViewDelegate
}

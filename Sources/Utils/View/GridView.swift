import UIKit
import Photos

class GridView: UIView {

  // MARK: - Initialization

  lazy var topView: UIView = self.makeTopView()
  lazy var bottomView: UIView = self.makeBottomView()
  lazy var bottomBlurView: UIVisualEffectView = self.makeBottomBlurView()
  lazy var arrowButton: ArrowButton = self.makeArrowButton()
  lazy var collectionView: UICollectionView = self.makeCollectionView()
  lazy var closeButton: UIButton = self.makeCloseButton()
  lazy var doneButton: UIButton = self.makeDoneButton()
  lazy var emptyView: UIView = self.makeEmptyView()
    
    var topViewHeightConstraint: NSLayoutConstraint?

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var heightAdjust: CGFloat = 0
        if #available(iOS 11, *) {
            heightAdjust = safeAreaInsets.top
        } else {
            heightAdjust = layoutMargins.top
        }
        if heightAdjust > 10 {
            heightAdjust -= 10
        }
        print("heighADJUST = \(heightAdjust)")
        topViewHeightConstraint?.constant = 44 + heightAdjust
    }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  func setup() {
    backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)

    [collectionView, bottomView, topView, emptyView].forEach {
      addSubview($0)
    }

    [closeButton, arrowButton].forEach {
      topView.addSubview($0)
    }

    [bottomBlurView, doneButton].forEach {
      bottomView.addSubview($0 as! UIView)
    }
    var heightAdjust: CGFloat = 0
    if #available(iOS 11, *) {
        heightAdjust = safeAreaInsets.top
    } else {
        heightAdjust = layoutMargins.top
    }

    topView.g_pinUpward()
    //topViewHeightConstraint = topView.g_pin(height: 44 + heightAdjust)
    
    topViewHeightConstraint = NSLayoutConstraint(item: topView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44 + heightAdjust)
    topView.addConstraint(topViewHeightConstraint!)
    
    bottomView.g_pinDownward()
    bottomView.g_pin(height: 70)

    emptyView.g_pinEdges(view: collectionView)
    
    collectionView.g_pinDownward()
    collectionView.g_pin(on: .top, view: topView, on: .bottom, constant: 1)

    bottomBlurView.g_pinEdges()

    closeButton.g_pin(on: .bottom)
    closeButton.g_pin(on: .left)
    closeButton.g_pin(size: CGSize(width: 44, height: 44))

    arrowButton.g_pin(on: .centerX)
    arrowButton.g_pin(on: .bottom)
    arrowButton.g_pin(height: 44)

    doneButton.g_pin(on: .centerY)
    doneButton.g_pin(on: .right, constant: -38)
  }

  // MARK: - Controls

  func makeTopView() -> UIView {
    let view = UIView()
    view.backgroundColor = UIColor.white

    return view
  }

  func makeBottomView() -> UIView {
    let view = UIView()
    view.backgroundColor = .clear
    return view
  }

  func makeBottomBlurView() -> UIVisualEffectView {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

    return view
  }

  func makeArrowButton() -> ArrowButton {
    let button = ArrowButton()
    button.layoutSubviews()

    return button
  }

  func makeGridView() -> GridView {
    let view = GridView()

    return view
  }

  func makeCloseButton() -> UIButton {
    let button = UIButton(type: .custom)
    button.setImage(GalleryBundle.image("gallery_close")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
    button.tintColor = Config.Grid.CloseButton.tintColor

    return button
  }

  func makeDoneButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitleColor(UIColor.white, for: UIControlState())
    button.setTitleColor(UIColor.lightGray, for: .disabled)
    button.titleLabel?.font = Config.Font.Text.regular.withSize(16)
    button.setTitle("Gallery.Done".g_localize(fallback: "Add Photo(s)"), for: UIControlState())
    
    return button
  }

  func makeCollectionView() -> UICollectionView {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 2
    layout.minimumLineSpacing = 2
    let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.backgroundColor = UIColor.white

    return view
  }

  func makeEmptyView() -> EmptyView {
    let view = EmptyView()
    view.isHidden = true

    return view
  }
}

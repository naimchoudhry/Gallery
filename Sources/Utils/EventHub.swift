import Foundation
import UIKit

class EventHub {

  typealias Action = () -> Void
    typealias ViewAction = (UIView) -> Void

  static let shared = EventHub()

  // MARK: Initialization

  init() {}

  var close: Action?
  var doneWithImages: Action?
  var doneWithVideos: Action?
  var stackViewTouched: ViewAction?
}

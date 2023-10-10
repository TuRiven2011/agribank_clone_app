import Foundation
import UIKit

protocol StoryBoardIdentifiable: AnyObject {
    static var storyboard: UIStoryboard { get }
}

extension StoryBoardIdentifiable {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
    }
}

extension StoryBoardIdentifiable where Self: UIViewController {
    
    static func instantiate(creator: @escaping (NSCoder) -> Self?) -> Self {
        if #available(iOS 13.0, *) {
            return storyboard.instantiateViewController(identifier: storyboardIdentifier, creator: creator)
        } else {
            return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
        }
    }
}

extension UIViewController: StoryBoardIdentifiable {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

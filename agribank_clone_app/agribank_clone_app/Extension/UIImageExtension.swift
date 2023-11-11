import Foundation
import UIKit

extension UIImage {
    convenience init?(colorFill: UIColor, size: CGSize) {
        let image = UIGraphicsImageRenderer(size: size).image { rendererContext in
            colorFill.setFill()
            UIRectFill(CGRect(origin: .zero, size: size))
        }
        
        guard let cgImage = image.cgImage else { return nil }
        
        self.init(cgImage: cgImage)
    }
}

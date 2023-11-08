

import Foundation
import UIKit

class CommonUtils {
    static let shared: CommonUtils = CommonUtils()
    
    private init() {
        
    }
    
    func openURL(urlString: String) {
        guard let url = URL(string: urlString) else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func makePhoneCall(phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

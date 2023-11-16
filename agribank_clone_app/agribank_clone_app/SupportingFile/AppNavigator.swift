

import Foundation
import UIKit

protocol AppNavigatorType: AnyObject {
    var window: UIWindow? { get }
    func start()
    func switchToMain()
    func swichToLogin()
    func switchTo(viewController: UIViewController)
}

final class AppNavigator: AppNavigatorType {
    
    let tabbar = TabbarViewController()
    var window: UIWindow?
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        
        switchToMain()
        
//        if AppData.isLogin {
//            switchToMain()
//        } else {
//            swichToLogin()
//        }
    }
    
    func swichToLogin() {
//        let vc = LoginViewController()
//        switchTo(viewController: UINavigationController(rootViewController: vc))
    }
    
    func switchToTransferHistory() {
        
    }
    func switchToNotification() {
        let vc = NotificationViewController()
        let navi = UINavigationController(rootViewController: vc)
        switchTo(viewController: navi)
    }
    
    func switchToHistory() {
        let vc = TransactionHistoryViewController()
        let navi = UINavigationController(rootViewController: vc)
        switchTo(viewController: navi)
    }
    
    func switchToMain() {
        switchTo(viewController: tabbar)
    }
    
    func switchTo(viewController: UIViewController) {
        guard let window = window else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: [.transitionCrossDissolve],
                          animations: {}, completion: {completed in
        })
    }
}

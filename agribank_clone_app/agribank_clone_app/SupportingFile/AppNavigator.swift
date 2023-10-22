

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
    var window: UIWindow?
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let vc = AppInforViewController()
        window?.rootViewController = vc
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
    
    func switchToMain() {
//        let vc = TabbarViewController()
//        switchTo(viewController: vc)
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

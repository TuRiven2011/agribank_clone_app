

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
    let navigation = UINavigationController()
    var window: UIWindow?
    init(window: UIWindow?) {
        self.window = window
        navigation.isNavigationBarHidden = true
        navigation.navigationBar.isHidden = true
        navigation.setNavigationBarHidden(true, animated: true)
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
        let vc = TransactionHistoryViewController()
        navigation.viewControllers = [vc]
    }
    func switchToNotification() {
        let vc = NotificationViewController()
        navigation.viewControllers = [vc]
    }
    
    func switchToHistory() {
        let vc = TransactionHistoryViewController()
        navigation.viewControllers = [vc]
    }
    
    func backToTabbar() {
        navigation.viewControllers = [tabbar]
    }
    
    func switchToMain() {
        
        switchTo(viewController: navigation)
        navigation.viewControllers = [tabbar]
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

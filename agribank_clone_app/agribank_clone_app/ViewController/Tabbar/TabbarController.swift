//
//  TabbarController.swift
//  agribank_clone_app
//
//  Created by Phạm Bá Tú on 16/10/2023.
//

import UIKit

class TabbarController: UITabBarController {
    
    let tab1 = UITabBarItem(title: "Trang chủ",
                            image: UIImage(named: "ic24PxHome_Normal"),
                            tag: 0)
    let tab2 = UITabBarItem(title: "Thông báo",
                            image: UIImage(named: "ic24PxNotification_Normal"),
                            tag: 1)
    let tab3 = UITabBarItem(title: "VnShop",
                            image: UIImage(named: "haioz"),
                            tag: 2)
    let tab4 = UITabBarItem(title: "Gọi Taxi",
                            image: UIImage(named: "tt"),
                            tag: 3)
    let tab5 = UITabBarItem(title: "Lịch sử GD",
                            image: UIImage(named: "ic24PxHistory_Normal"),
                            tag: 3)
    
    let home = HomeViewController()
    let notification = ViewController()
    let vnShop = ViewController()
    let taxi = ViewController()
    let historyTransaction = ViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initItem()
        configUI()
        
    }

    private func configUI() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        self.view.backgroundColor = .white
        self.tabBar.backgroundColor = .white
        self.popoverPresentationController?.backgroundColor = .white
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        self.tabBar.tintColor = UIColor(rgb: 0xFF006641)
        self.selectedIndex = 0
    }
    
    private func initItem() {
        
        let tab1NavigationController = UINavigationController(rootViewController: home)
        let tab2NavigationController = UINavigationController(rootViewController: notification)
        let tab3NavigationController = UINavigationController(rootViewController: vnShop)
        let tab4NavigationController = UINavigationController(rootViewController: taxi)
        let tab5NavigationController = UINavigationController(rootViewController: historyTransaction)
        
        tab1NavigationController.tabBarItem = tab1
        tab2NavigationController.tabBarItem = tab2
        tab3NavigationController.tabBarItem = tab3
        tab4NavigationController.tabBarItem = tab4
        tab5NavigationController.tabBarItem = tab5
        
        self.viewControllers = [
            tab1NavigationController,
            tab2NavigationController,
            tab3NavigationController,
            tab4NavigationController,
            tab5NavigationController
        ]
        
    }
    
    
}

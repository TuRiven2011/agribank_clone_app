//
//  MainTabbarController.swift
//  agribank_clone_app
//
//  Created by Phạm Bá Tú on 30/10/2023.
//

import UIKit

class TabbarViewController: UITabBarController {
    

    let tab1 = UITabBarItem(title: "Trang chủ",
                            image: UIImage(named: "ic24PxHomeWhite_Normal"),
                            tag: 1)
    
    let tab2 = UITabBarItem(title: "Thông báo",
                            image: UIImage(named: "ic24PxNotification_Normal"),
                            tag: 2)
    
    let tab3 = UITabBarItem(title: "VnShop",
                            image: UIImage(named: "qlcn"),
                            tag: 3)
    
    let tab4 = UITabBarItem(title: "Gọi Taxi",
                            image: UIImage(named: "qlcn"),
                            tag: 4)
    
    let tab5 = UITabBarItem(title: "Lịch sử GD",
                            image: UIImage(named: "ic24PxHistory_Normal"),
                            tag: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initItem()
        configUI()
        initSideMenu()
        // Do any additional setup after loading the view.
    }
    
    private func initSideMenu() {
        
    }
    
    private func configUI() {
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = UIColor(rgb: 0xff075E41)
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        self.tabBarController?.tabBar.backgroundColor = .white
        
        self.selectedIndex = 0
    }
    
    
    private func initItem() {
        let tab1NavigationController = UINavigationController(rootViewController: HomeViewController())
        let tab2NavigationController = UINavigationController(rootViewController: ViewController())
        let tab3NavigationController = UINavigationController(rootViewController: ViewController())
        let tab4NavigationController = UINavigationController(rootViewController: ViewController())
        let tab5NavigationController = UINavigationController(rootViewController: ViewController())
        
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
    
    deinit {
        
    }
    
}

extension TabbarViewController {
    
}

extension Notification.Name {
    static let SHOW_SIDE_MENU = Notification.Name("SHOW_SIDE_MENU")
    static let SELECT_TAB_BAR = Notification.Name("SELECT_TAB_BAR")
}

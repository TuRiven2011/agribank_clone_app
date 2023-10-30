//
//  HomeViewController.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 11/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        configTbl()
        NotificationCenter.default.addObserver(self, selector: #selector(pushSettings), name: Notification.Name("Open Settings"), object: nil)
    }
    
    private func setupNavigationBar() {

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .white
            appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            
        } else {
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationController?.navigationBar.barTintColor = .white
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        let search = UIImageView(image: .init(named: "ic32PxSearch_Normal"))
        search.isUserInteractionEnabled = true
        search.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.navigationBar.addSubview(search)
        
        if let navigationBar = navigationController?.navigationBar {
            [
                search.widthAnchor.constraint(equalToConstant: 30),
                search.heightAnchor.constraint(equalToConstant: 30),
                search.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 20),
                search.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -10),
            ].forEach({$0.isActive = true})
        }
        
        let menu = UIImageView(image: .init(named: "ic32PxRightmenu_Normal"))
        menu.isUserInteractionEnabled = true
        
        menu.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.navigationBar.addSubview(menu)
        
        if let navigationBar = navigationController?.navigationBar {
            [
                menu.widthAnchor.constraint(equalToConstant: 30),
                menu.heightAnchor.constraint(equalToConstant: 30),
                menu.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -20),
                menu.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -10),
            ].forEach({$0.isActive = true})
        }
        
        let logo = UIImageView(image: .init(named: "QR_Agri_Normal"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.navigationBar.addSubview(logo)
        
        if let navigationBar = navigationController?.navigationBar {
            [
                logo.widthAnchor.constraint(equalToConstant: 170),
                logo.heightAnchor.constraint(equalToConstant: 50),
                logo.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
                logo.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor, constant: -3),
            ].forEach({$0.isActive = true})
        }
        navigationController?.additionalSafeAreaInsets.top = 6

    }
    
    func configTbl() {
        tableview.register(.init(nibName: "LoginTableViewCell", bundle: nil), forCellReuseIdentifier: "LoginTableViewCell")
        tableview.register(.init(nibName: "AccountInforTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountInforTableViewCell")
        tableview.register(.init(nibName: "OptionsTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionsTableViewCell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 200
    }
    
    @objc func pushSettings(_ noti: Notification) {
        let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoginTableViewCell") as? LoginTableViewCell else {return UITableViewCell()}
        guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "AccountInforTableViewCell") as? AccountInforTableViewCell else {return UITableViewCell()}
        cell2.tapCardServiceCompletion = {[weak self] in
            
            guard let self = self else {return}
            let vc = CardServiceViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        guard let cell3 = tableView.dequeueReusableCell(withIdentifier: "OptionsTableViewCell") as? OptionsTableViewCell else {return UITableViewCell()}
        
        if indexPath.row == 0 {
            return cell
        }
        if indexPath.row == 1 {
            return cell2
        }
        if indexPath.row == 2 {
            return cell3
        }
        return UITableViewCell()
    }
    
    
    
    
}

//
//  HomeViewController.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 11/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    let listGroupFeature: [HomeGroupFeatureEnum] = HomeGroupFeatureEnum.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigationBar()
        configTableViews()
        NotificationCenter.default.addObserver(self, selector: #selector(pushSettings), name: Notification.Name("Open Settings"), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func configNavigationBar() {
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
            self.navigationController?.navigationBar.barTintColor = .white
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        let leftButton = UIBarButtonItem(image: .init(named: "ic32PxSearch_Normal"), style: .done, target: self, action: #selector(handleSearchTransaction))
        
        let rightButton = UIBarButtonItem(image: .init(named: "ic32PxRightmenu_Normal"), style: .done, target: self, action: #selector(handleSearchTransaction))
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        let image = UIImage(named: "QR_Agri_Normal")
        imageView.image = image
        [
            imageView.widthAnchor.constraint(equalToConstant: 130),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ].forEach({$0.isActive = true})
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.titleView = imageView
        navigationController?.additionalSafeAreaInsets.top = 10
    }
    
    private func configTableViews() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(.init(nibName: "LoginTableViewCell", bundle: nil), forCellReuseIdentifier: "LoginTableViewCell")
        tableview.register(.init(nibName: "AccountInforTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountInforTableViewCell")
        tableview.register(.init(nibName: "OptionsTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionsTableViewCell")
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 200
    }
    
}

extension HomeViewController {
    @objc func pushSettings(_ noti: Notification) {
        let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func handleSearchTransaction() {
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listGroupFeature.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch HomeGroupFeatureEnum(rawValue: indexPath.row) {
        case .finance:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoginTableViewCell") as? LoginTableViewCell else {return UITableViewCell()}
            return cell
        case .shopping:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountInforTableViewCell") as? AccountInforTableViewCell else {return UITableViewCell()}
            return cell
        case .utilities:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsTableViewCell") as? OptionsTableViewCell else {return UITableViewCell()}
            return cell
        default:
            return .init()
        }
    }
    
    
    
    
}

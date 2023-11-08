//
//  BaseViewController.swift
//  agribank_clone_app
//
//  Created by Phạm Bá Tú on 01/11/2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    func setupNavigationBar(title: String) {
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .yellow
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
        
        navigationController?.navigationBar.subviews.forEach({$0.removeFromSuperview()})
        self.navigationItem.setHidesBackButton(true, animated: true)
                
        let back = UIImageView(image: .init(named: "ic_24px_back_Normal"))
        back.isUserInteractionEnabled = true
        back.translatesAutoresizingMaskIntoConstraints = false
        back.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))

        navigationController?.navigationBar.addSubview(back)
        
        if let navigationBar = navigationController?.navigationBar {
            [
                back.widthAnchor.constraint(equalToConstant: 30),
                back.heightAnchor.constraint(equalToConstant: 30),
                back.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 20),
                back.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -10),
            ].forEach({$0.isActive = true})
        }
        
        let backButtonItem = UIBarButtonItem(customView: back)
        
        navigationController?.navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.title = title
        
        
    }
    
}

extension BaseViewController {
    @objc func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}

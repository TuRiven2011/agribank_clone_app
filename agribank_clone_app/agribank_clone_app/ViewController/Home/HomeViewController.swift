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
        
        configTbl()
        
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

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoginTableViewCell") as? LoginTableViewCell else {return UITableViewCell()}
        guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "AccountInforTableViewCell") as? AccountInforTableViewCell else {return UITableViewCell()}
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

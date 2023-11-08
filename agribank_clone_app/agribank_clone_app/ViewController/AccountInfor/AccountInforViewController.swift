//
//  AccountInforViewController.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 07/11/2023.
//

import UIKit

class AccountInforViewController: BaseViewController {
    
    @IBOutlet weak var accoutNumberLbl: UILabel!
    @IBOutlet weak var accountSurplusLbl: UILabel!
    
    let dataAccount = AccountInfor.init(number: "12004240240404", surplus: "304,900 VND")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTextForLbl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(title: "Thông tin tài khoản")
    }
    
    func setTextForLbl() {
        accoutNumberLbl.text = dataAccount.number
        accountSurplusLbl.text = dataAccount.surplus
    }




}

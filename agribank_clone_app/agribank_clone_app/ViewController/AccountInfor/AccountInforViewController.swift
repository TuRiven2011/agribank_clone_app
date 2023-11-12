//
//  AccountInforViewController.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 07/11/2023.
//

import UIKit

class AccountInforViewController: BaseViewController {
    
    @IBOutlet weak var nickNameManagerButton: UIButton!
    @IBOutlet weak var accoutNumberLbl: UILabel!
    @IBOutlet weak var accountSurplusLbl: UILabel!
        
    @IBOutlet weak var showPaymentAccountView
    : UIImageView!
    
    @IBOutlet weak var showCopyAlertView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showCopyAlertView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showCopyAlert(_:))))
        showPaymentAccountView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPaymentAccountView(_:))))
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(title: "Thông tin tài khoản")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nickNameManagerButton.applyGradient(colours: [.init(rgb: 0xffDF8B31), .init(rgb: 0xffC46826)],
                                            start: .init(x: 0, y: 0),
                                            end: .init(x: 1, y: 0))
    }
    
    func configUI() {
        accoutNumberLbl.text = AppData.account?.numberAccount ?? ""
        if let balance = AppData.account?.balance {
            accountSurplusLbl.text = "\(String(describing: balance.addComma()) ) VND"
        }
        nickNameManagerButton.layer.cornerRadius = 25
        nickNameManagerButton.layer.masksToBounds = true
    }

    @objc func handleShowDetail(_ g: UITapGestureRecognizer) {
        
        let vc = PaymentAccountViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showCopyAlert(_ g: UITapGestureRecognizer) {
        let vc = CopyAccountInforView()
        vc.backCompletion = {
            vc.removeFromSuperview()
        }
        vc.frame = UIScreen.main.bounds
        self.view.addSubview(vc)
    }
    
    @objc func showPaymentAccountView(_ g: UITapGestureRecognizer) {
        let vc = PaymentAccountViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }


}

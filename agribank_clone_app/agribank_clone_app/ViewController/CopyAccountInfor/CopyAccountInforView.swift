//
//  CopyAccountInforView.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 10/11/2023.
//

import UIKit

class CopyAccountInforView: UIView {


    @IBOutlet weak var accountNumLbl1: UILabel!
    
    @IBOutlet weak var accountNumLbl2: UILabel!
    
    @IBOutlet weak var accountName: UILabel!
    
    @IBOutlet weak var place: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    
    func commonInit() {
        
        guard let copyview = UINib(nibName: "CopyAccountInforView", bundle: nil).instantiate(withOwner: self).first as? UIView else {return}
        
        addSubview(copyview)
        copyview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            copyview.leadingAnchor.constraint(equalTo: leadingAnchor),
            copyview.trailingAnchor.constraint(equalTo: trailingAnchor),
            copyview.topAnchor.constraint(equalTo: topAnchor),
            copyview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        copyview.backgroundColor = .clear
        layoutSubviews()
        if let account = AppData.account {
            accountNumLbl1.text = AppData.account?.numberAccount
            accountNumLbl2.text = "Số tài khoản: \(account.numberAccount ?? "")"
            accountName.text = "Chủ tài khoản: \(account.userName ?? "")"
            place.text = "Chi nhánh mở: \(account.openBranch ?? "")"
        }
       
        
    }
    
}

//
//  AppInforTableViewCell.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 20/10/2023.
//

import UIKit

class AppInforTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var inforLbl: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func binding(_ title: String, infor: String, index: Int) {
        if index == 0 {
            lineView.alpha = 0
        }
        self.titleLbl.text = title
        self.inforLbl.text = infor
    }
    
}

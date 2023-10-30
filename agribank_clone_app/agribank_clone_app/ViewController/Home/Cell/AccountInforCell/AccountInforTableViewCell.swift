//
//  AccountInforTableViewCell.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 11/10/2023.
//

import UIKit

class AccountInforTableViewCell: UITableViewCell {

    @IBOutlet weak var cardServiceView: UIView!
    
    var tapCardServiceCompletion: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configGesture()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configGesture() {
        cardServiceView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCardService)))
    }
    
}

extension AccountInforTableViewCell {
    @objc func handleCardService() {
        tapCardServiceCompletion?()
    }
}

//
//  TransferTableViewCell.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 16/10/2023.
//

import UIKit

class TransferTableViewCell: UITableViewCell {

    @IBOutlet weak var banklogoImage: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var accountNumberLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func binding(_ name: String,_ accountnumber: String,_ image: String) {
        self.nameLbl.text = name
        self.accountNumberLbl.text = accountnumber
        self.banklogoImage.image = UIImage(named: image)
    }
    
}

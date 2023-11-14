//
//  BankCollectionViewCell.swift
//  agribank_clone_app
//
//  Created by Tú Phạm Bá on 13/11/2023.
//

import UIKit

class BankCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bankImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func binding(data: AppBankEnum) {
        bankImage.image = data.image ?? .init()
    }

}

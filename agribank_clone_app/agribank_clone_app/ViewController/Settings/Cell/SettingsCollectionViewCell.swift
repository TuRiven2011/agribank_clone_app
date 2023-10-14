//
//  SettingsCollectionViewCell.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 13/10/2023.
//

import UIKit

class SettingsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func biding(_ title: String, image: String) {
        titleLbl.text = title
        imageViewCell.image = UIImage(named: image)
    }

}

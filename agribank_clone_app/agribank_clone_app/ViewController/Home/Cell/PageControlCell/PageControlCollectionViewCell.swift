//
//  PageControlCollectionViewCell.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 06/11/2023.
//

import UIKit

class PageControlCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func binding(_ image: UIImage) {
        imageView.image = image
    }

}

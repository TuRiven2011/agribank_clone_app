//
//  SearchFeatureCollectionViewCell.swift
//  agribank_clone_app
//
//  Created by Phạm Bá Tú on 09/11/2023.
//

import UIKit

class SearchFeatureCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var suggestLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func binding(suggest: String) {
        suggestLabel.text = suggest
    }

}



import UIKit

class HomeCustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewCell: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func binding(_ title: String, image: String) {
        lblTitle.text = title
        if let image = UIImage(named: image) {
            imageViewCell.image = image
        }
    }

}

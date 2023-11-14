

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

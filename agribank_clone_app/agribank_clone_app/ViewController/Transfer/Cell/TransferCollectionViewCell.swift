

import UIKit

class TransferCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageviewCell: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func binding(_ title: String,_ image: String) {
        self.titleLbl.text = title
        self.imageviewCell.image = UIImage(named: image)
    }

}

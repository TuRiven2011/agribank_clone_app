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

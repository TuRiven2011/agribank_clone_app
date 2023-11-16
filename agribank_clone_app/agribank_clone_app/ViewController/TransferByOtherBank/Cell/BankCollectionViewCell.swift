
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

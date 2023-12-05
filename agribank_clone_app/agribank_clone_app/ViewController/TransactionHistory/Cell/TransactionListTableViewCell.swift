

import UIKit

class TransactionListTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func binding(data: TransferModel) {
        if data.isReceive == false {
            moneyLabel.textColor = UIColor(rgb: 0xFFE3734F)
            moneyLabel.text = "- \(data.money?.addComma() ?? "") VND"
        } else {
            moneyLabel.textColor = UIColor(rgb: 0xFF64B084)
            moneyLabel.text = "+ \(data.money?.addComma() ?? "") VND"
        }
        dateLabel.text = data.date?.formatToString()
        contentLabel.text = data.content ?? ""
    }
    
}

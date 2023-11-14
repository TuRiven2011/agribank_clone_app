import UIKit

class PaymentAccountViewController: BaseViewController {
    
    @IBOutlet weak var accountNumLbl: UILabel!
    
    @IBOutlet weak var accountNameLbl: UILabel!
    
    @IBOutlet weak var accountPlaceLbl: UILabel!
    
    @IBOutlet weak var accountBalanceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(title: "Tài khoản thanh toán")
    }

    func config() {
        if let account = AppData.account {
            accountNumLbl.text = account.numberAccount
            accountNameLbl.text = account.userName
            accountPlaceLbl.text = account.openBranch
            accountBalanceLbl.text = "Số dư: \(account.balance?.addComma() ?? "0") VND"
        }
        
    }


}

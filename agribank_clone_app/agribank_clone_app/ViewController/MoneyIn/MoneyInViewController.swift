import UIKit

class MoneyInViewController: BaseViewController {

    @IBAction func doneTap(_ sender: Any) {
//        let account = AccountModel(userName: usernameString,
//                                   numberAccount: numberAccountString,
//                                   balance: balance,
//                                   openBranch: openBranch)
//        AppData.account = account
        
        guard let account = AppData.account else {return}
        var newData = account
        if let money = Int(moneyLabel.text ?? "0") {
            newData.balance = (account.balance ?? 0) + money
        }
        
        AppData.account = newData
        
        let billModel = TransferModel(userName: AppData.account?.userName,
                                      numberAccount: AppData.account?.numberAccount,
                                      balance: AppData.account?.balance,
                                      openBranch: AppData.account?.openBranch,
                                      content: contentLabel.text,
                                      money: Int(moneyLabel.text ?? "0"),
                                      numberAccount2: accountLabel.text,
                                      bank2: bankLabel.text,
                                      date: .init(),
                                      isReceive: true
        )
        
        AppData.listTransaction?.append(billModel)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var bankLabel: UITextField!
    @IBOutlet weak var contentLabel: UITextField!
    @IBOutlet weak var branch: UITextField!
    @IBOutlet weak var moneyLabel: UITextField!
    @IBOutlet weak var accountLabel: UITextField!
    
    var accountString: String?
    var contentString: String?
    var money: Int?
    var branchString: String?
    var bankString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(title: "chuyển tiền vào".uppercased())
    }
    
    private func configTextFields() {
        bankLabel.delegate = self
        contentLabel.delegate = self
        branch.delegate = self
        moneyLabel.delegate = self
        accountLabel.delegate = self
    }

}

extension MoneyInViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case bankLabel:
             bankString = self.bankLabel.text
        case contentLabel:
            contentString = self.contentLabel.text
        case branch:
            branchString = branch.text
        case moneyLabel:
            money = Int(self.moneyLabel.text ?? "0")
        case accountLabel:
            accountString = self.accountLabel.text
        default:
            break
        }
    }
}

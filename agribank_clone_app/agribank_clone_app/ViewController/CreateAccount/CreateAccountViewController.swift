
import UIKit

class CreateAccountViewController: BaseViewController {

    @IBOutlet weak var numberAccount: UITextField!
    @IBOutlet weak var userNameLabel: UITextField!    
    @IBOutlet weak var balanceLabel: UITextField!
    @IBOutlet weak var openBranchTextField: UITextField!
    
    @IBAction func doneTap(_ sender: Any) {
        let account = AccountModel(userName: usernameString?.uppercased(),
                                   numberAccount: numberAccountString,
                                   balance: balance,
                                   openBranch: openBranch)
        AppData.account = account
        
        navigationController?.popViewController(animated: true)
    }
    
    var usernameString: String?
    var numberAccountString: String?
    var balance: Int?
    var openBranch: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configTextFields()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(title: "Tạo tài khoản")
    }
    
    private func configTextFields() {
        numberAccount.delegate = self
        userNameLabel.delegate = self
        balanceLabel.delegate = self
        openBranchTextField.delegate = self
    }


    

}

extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case self.numberAccount:
            numberAccountString = self.numberAccount.text
        case self.userNameLabel:
            usernameString = self.userNameLabel.text
        case balanceLabel:
            balance = Int(self.balanceLabel.text ?? "0")
        case openBranchTextField:
            openBranch = self.openBranchTextField.text
        default:
            break
        }
    }
}

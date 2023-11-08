//
//  CreateAccountViewController.swift
//  agribank_clone_app
//
//  Created by Phạm Bá Tú on 08/11/2023.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var numberAccount: UITextField!
    @IBOutlet weak var userNameLabel: UITextField!    
    @IBOutlet weak var balanceLabel: UITextField!
    
    @IBAction func doneTap(_ sender: Any) {
        let account = AccountModel(userName: usernameString,
                                   numberAccount: numberAccountString,
                                   balance: balance)
        AppData.account = account
    }
    
    var usernameString: String?
    var numberAccountString: String?
    var balance: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configTextFields()
        // Do any additional setup after loading the view.
    }
    
    private func configTextFields() {
        numberAccount.delegate = self
        userNameLabel.delegate = self
        balanceLabel.delegate = self
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
        default:
            break
        }
    }
}

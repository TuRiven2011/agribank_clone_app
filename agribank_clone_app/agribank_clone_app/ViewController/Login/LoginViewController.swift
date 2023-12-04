

import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func closeHandle(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        AppData.isLogin = true
        loginCompletion?()
        dismiss(animated: true)
    }
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var textFieldPassword: UITextField!
    var passwordText = String()
    var loginCompletion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldPassword.delegate = self
        loginButton.applyGradient(colours: [.init(rgb: 0xffDF8B31), .init(rgb: 0xffC46826)],
                                  start: .init(x: 0, y: 0),
                                  end: .init(x: 1, y: 0))
        loginButton.layer.cornerRadius = 25
        loginButton.layer.masksToBounds = true
    }
    
    
    
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == textFieldPassword {
            
            var hashPassword = String()
            let newChar = string.first
            let offsetToUpdate = passwordText.index(passwordText.startIndex, offsetBy: range.location)
            
            if string == "" {
                passwordText.remove(at: offsetToUpdate)
                return true
            }
            else { passwordText.insert(newChar!, at: offsetToUpdate) }
            
            for _ in passwordText {  hashPassword += "•" }
            textField.attributedText = .init(string: hashPassword, attributes: [.foregroundColor: UIColor(rgb: 0xffDC8630), .font: UIFont.systemFont(ofSize: 20, weight: .bold)])
            return false
        } else {
            return true
        }
    }
}

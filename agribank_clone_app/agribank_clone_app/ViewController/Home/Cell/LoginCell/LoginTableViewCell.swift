import UIKit

class LoginTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var splashLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var loginCompletion: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func binding() {
        if AppData.isLogin == true {
            loginButton.isHidden = true
            userNameLabel.isHidden = false
            splashLabel.isHidden = false
            userNameLabel.text = AppData.account?.userName
        } else {
            loginButton.isHidden = false
            userNameLabel.isHidden = true
            splashLabel.isHidden = true
        }
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        loginCompletion?()
    }
    
    
}

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}


import UIKit

class CreateAccountViewController: BaseViewController, UINavigationControllerDelegate {

    @IBOutlet weak var qrImage: UIImageView!
    @IBOutlet weak var addQRButton: UILabel!
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
    
    let imagePickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        configTextFields()
        addQRButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addImageQR)))
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


    @objc func addImageQR() {
        present(imagePickerController, animated: true)
    }

}

extension CreateAccountViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        let tempImage = info[.originalImage] as! UIImage
        ImageToManager.shared.saveImage(image: tempImage)
        
        if let image = ImageToManager.shared.getSavedImage(named: "fileName") {
            qrImage.image = image
            // do something with image
        }
        
        
        dismiss(animated: true)
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

@available(iOSApplicationExtension 10.0, *)
extension CreateAccountViewController {
    
     func saveImageToDisk(fileIdentifier: String, data: NSData, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
        let fileManager = FileManager.default
        let folderName = ProcessInfo.processInfo.globallyUniqueString
        let folderURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(folderName, isDirectory: true)
        
        do {
            try fileManager.createDirectory(at: folderURL!, withIntermediateDirectories: true, attributes: nil)
            let fileURL = folderURL?.appendingPathComponent(fileIdentifier)
            try data.write(to: fileURL!, options: [])
            let attachment = try UNNotificationAttachment(identifier: fileIdentifier, url: fileURL!, options: options)
            return attachment
        } catch let error {
            print("error \(error)")
        }
        
        return nil
    }
}

class ImageToManager {
    static let shared = ImageToManager()
    
    func saveImage(image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("fileName.png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
}

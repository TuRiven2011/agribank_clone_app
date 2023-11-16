import UIKit

class PastInTransactionViewController: BaseViewController {
    
    @IBAction func doneACtion(_ sender: Any) {
        let billModel = TransferModel(userName: AppData.account?.userName,
                                      numberAccount: AppData.account?.numberAccount,
                                      balance: AppData.account?.balance,
                                      openBranch: AppData.account?.openBranch,
                                      content: contentTF.text,
                                      money: Int(moneyTF.text ?? "0"),
                                      numberAccount2: numberAccount2TF.text,
                                      bank2: bank2TF.text,
                                      date: dateTF.text?.toDate(),
                                      isReceive: false
        )
        
        AppData.listTransaction?.append(billModel)
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var contentTF: UITextField!
    @IBOutlet weak var balanceTF: UITextField!
    @IBOutlet weak var moneyTF: UITextField!
    @IBOutlet weak var bank2TF: UITextField!
    @IBOutlet weak var numberAccount2TF: UITextField!
    @IBOutlet weak var name2TF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(title: "Nhận tiền quá khứ".uppercased())
    }



}

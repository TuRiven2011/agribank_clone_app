import UIKit

class PastOutTransactionViewController: BaseViewController {
    
    @IBAction func doneACtion(_ sender: Any) {
        
        if let transfer = transfer {
            if let index = AppData.listTransaction?.firstIndex(where: {$0.id == transfer.id}) {
                AppData.listTransaction?.removeAll(where: {$0.id == transfer.id})
                let billModel = TransferModel(userName: AppData.account?.userName,
                                              numberAccount: AppData.account?.numberAccount,
                                              balance: Int(balanceTF.text ?? "0"),
                                              openBranch: AppData.account?.openBranch,
                                              content: contentTF.text,
                                              money: Int(moneyTF.text ?? "0"),
                                              name2: name2TF.text,
                                              numberAccount2: numberAccount2TF.text,
                                              bank2: bank2TF.text,
                                              date: dateTF.text?.toDate(),
                                              isReceive: false
                )
                
                AppData.listTransaction?.insert(billModel, at: index)
            }
            editComplete?()
        } else {
            let billModel = TransferModel(userName: AppData.account?.userName,
                                          numberAccount: AppData.account?.numberAccount,
                                          balance: Int(balanceTF.text ?? "0"),
                                          openBranch: AppData.account?.openBranch,
                                          content: contentTF.text,
                                          money: Int(moneyTF.text ?? "0"),
                                          name2: name2TF.text,
                                          numberAccount2: numberAccount2TF.text,
                                          bank2: bank2TF.text,
                                          date: dateTF.text?.toDate(),
                                          isReceive: false
            )
            
            AppData.listTransaction?.append(billModel)
        }
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var contentTF: UITextField!
    @IBOutlet weak var balanceTF: UITextField!
    @IBOutlet weak var moneyTF: UITextField!
    @IBOutlet weak var bank2TF: UITextField!
    @IBOutlet weak var numberAccount2TF: UITextField!
    @IBOutlet weak var name2TF: UITextField!
    
    var transfer: TransferModel? = nil
    var editComplete: (() -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let transfer = transfer {
            dateTF.text = transfer.date?.formatToString()
            contentTF.text = transfer.content ?? ""
            balanceTF.text = "\(transfer.balance ?? 0)"
            moneyTF.text = "\(transfer.money ?? 0)"
            bank2TF.text = transfer.bank2 ?? ""
            numberAccount2TF.text = transfer.numberAccount2 ?? ""
            name2TF.text = transfer.name2 ?? ""
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(title: "Chuyển tiền quá khứ".uppercased())
    }
    
}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) ?? .init() // rep
    }
}

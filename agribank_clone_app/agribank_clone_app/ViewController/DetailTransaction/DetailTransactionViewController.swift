import UIKit

class DetailTransactionViewController: BaseViewController {
    
    let data: TransferModel
    
    required init(data: TransferModel) {
        self.data = data
        super.init(nibName: "DetailTransactionViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var accountPayLabel: UILabel!
    @IBOutlet weak var typeMoneyLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(title: "Chi tiết giao dịch".uppercased())
    }
    
    private func setup() {
        dateLabel.text = data.date?.format(partern: "dd/MM/yyyy")
        timeLabel.text = data.date?.format(partern: "HH:mm")
        moneyLabel.text = data.money?.addComma() ?? ""
        branchLabel.text = data.openBranch ?? ""
        typeMoneyLabel.text = "VND"
        accountPayLabel.text = data.numberAccount2 ?? ""
        contentLabel.text = data.content ?? ""
        balanceLabel.text = data.balance?.addComma() ?? ""
    }

}

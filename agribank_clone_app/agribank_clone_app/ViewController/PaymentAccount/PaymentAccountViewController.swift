import UIKit

class PaymentAccountViewController: BaseViewController {
    
    @IBOutlet weak var accountNumLbl: UILabel!
    @IBOutlet weak var accountNameLbl: UILabel!
    @IBOutlet weak var accountPlaceLbl: UILabel!
    @IBOutlet weak var accountBalanceLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var buttonCollection: [UIButton]!
    
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
        tableView.register(.init(nibName: "TransactionListTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}

extension PaymentAccountViewController {
    
    @objc func handle(_ g: UITapGestureRecognizer) {
        buttonCollection.forEach { button in
            if g.view?.tag == button.tag {
                button.layer.borderColor = UIColor(red: 220/255, green: 114/255, blue: 27/255, alpha: 1).cgColor
                button.tintColor =  UIColor(red: 220/255, green: 114/255, blue: 27/255, alpha: 1)
            } else {
                button.layer.borderColor = UIColor.clear.cgColor
                button.tintColor = UIColor(red: 89/255, green: 89/255, blue: 89/255, alpha: 1)
            }
        }
 
    }
    
    @objc func showPickerDate() {
//        navigationController?.pushViewController(datePicker, animated: true)
        self.view.addSubview(datePicker)
    }
}

extension PaymentAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listHistory?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionListTableViewCell") as? TransactionListTableViewCell else {return UITableViewCell()}
        
        if let listHistory = listHistory {
            cell.binding(data: listHistory[indexPath.row])
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
}

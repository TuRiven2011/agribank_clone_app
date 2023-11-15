

import UIKit

class TransactionHistoryViewController: BaseViewController {
    
    @IBOutlet weak var openBranchLabel: UILabel!
    @IBOutlet weak var numberAccount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var startDateView: UIView!
    
    let listHistory = AppData.listTransaction
    let datePicker = UIDatePicker()
    
    let enumM: TransactionEnum? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar(title: "LỊCH SỬ GIAO DỊCH")
        configTableView()
        datePicker.datePickerMode = .date
//        datePicker.
        numberAccount.text = AppData.account?.numberAccount ?? ""
        openBranchLabel.text = AppData.account?.openBranch ?? ""
        buttonCollection.forEach { button in
            button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handle(_:))))
        }
        startDateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPickerDate)))
    }
    
    func configTableView() {
        tableView.register(.init(nibName: "TransactionListTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension TransactionHistoryViewController {
    
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

extension TransactionHistoryViewController: UITableViewDelegate, UITableViewDataSource {
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

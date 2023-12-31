import UIKit

class PaymentAccountViewController: BaseViewController {
    
    @IBOutlet weak var qrCode: UIImageView!
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var accountNumLbl: UILabel!
    @IBOutlet weak var accountNameLbl: UILabel!
    @IBOutlet weak var accountPlaceLbl: UILabel!
    @IBOutlet weak var accountBalanceLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var startDateView: UIView!
    
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    
    @IBOutlet weak var selectView: UIView!
    
    var listHistory = AppData.listTransaction?.sorted(by: {($0.date ?? .init()) < ($1.date ?? .init())})
    var listDataToShow: [TransferModel] = []
    var type = TransactionEnum.total
    let datePicker = UIDatePicker()
    var start: Date = .init()
    var end: Date = .init()
    var isSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        endDateLabel.text = Date().format(partern: "dd/MM/yyyy")
        
        
        var dateComponents = DateComponents()
        dateComponents.year = Calendar.current.component(.year, from: .init())
        dateComponents.month = Calendar.current.component(.month, from: .init())
        
        let calendar = NSCalendar.current
        let range = calendar.range(of: .day, in: .month, for: .init())
        
        let dayComp = DateComponents(day: -(range?.count ?? 0))
        let date = Calendar.current.date(byAdding: dayComp, to: Date())
        start = date ?? .init()
        startDateLabel.text = date?.format(partern: "dd/MM/yyyy")
        
        
        datePicker.datePickerMode = .date
        buttonCollection.forEach { button in
            button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handle(_:))))
        }
        startDateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPickerStartDate)))
        endDateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPickerEndDate)))
        searchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchTransaction)))
        
        if let image = ImageToManager.shared.getSavedImage(named: "fileName") {
            qrCode.image = image
            // do something with image
        }
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
            
            if isSearch {
                listDataToShow.removeAll()
                guard let listHistory = listHistory else {return}
                if g.view?.tag == 0 {
                    type = .total
                    listHistory.forEach {[weak self] element in
                        guard let self = self else {return}
                        if (element.date ?? .init()) >= self.start && (element.date ?? .init()) <= self.end {
                            self.listDataToShow.append(element)
                        }
                    }
                } else if g.view?.tag == 1 {
                    type = .moneyIn
                    listHistory.forEach {[weak self] element in
                        guard let self = self else {return}
                        if element.isReceive == true && (element.date ?? .init()) >= self.start && (element.date ?? .init()) <= self.end {
                            self.listDataToShow.append(element)
                        }
                    }
                } else {
                    type = .moneyOut
                    listHistory.forEach {[weak self] element in
                        guard let self = self else {return}
                        if element.isReceive == false && (element.date ?? .init()) >= self.start && (element.date ?? .init()) <= self.end {
                            self.listDataToShow.append(element)
                        }
                    }
                }
                tableView.reloadData()
            }
        }
        
    }
    
    @objc func showPickerStartDate() {
        PickTimeView.shared.show(time: .init()) {[weak self] date in
            guard let self = self else {return}
            self.start = date
            self.startDateLabel.text = date.format(partern: "dd/MM/yyyy")
        }
    }
    
    @objc func showPickerEndDate() {
        PickTimeView.shared.show(time: .init()) {[weak self] date in
            guard let self = self else {return}
            self.end = date
            self.endDateLabel.text = date.format(partern: "dd/MM/yyyy")
        }
    }
    
    @objc func searchTransaction() {
        helpLabel.isHidden = true
        selectView.isHidden = false
        tableView.isHidden = false
        isSearch = true
        listHistory = AppData.listTransaction?.sorted(by: {($0.date ?? .init()) > ($1.date ?? .init())})
        listDataToShow.removeAll()
        print("\(start.formatToString()) \(end.formatToString()) BA TU")
        if let listHistory = listHistory {
            listHistory.forEach {[weak self] element in
                guard let self = self else {return}
                if (element.date ?? .init()) >= self.start && (element.date ?? .init()) <= self.end {
                    switch self.type {
                    case .moneyOut:
                        if element.isReceive == false {
                            self.listDataToShow.append(element)
                        }
                    case .moneyIn:
                        if element.isReceive == true {
                            self.listDataToShow.append(element)
                        }
                    case .total:
                        self.listDataToShow.append(element)
                    }
                }
            }
        }
        
        tableView.reloadData()
    }

}

extension PaymentAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listDataToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionListTableViewCell") as? TransactionListTableViewCell else {return UITableViewCell()}
        
            cell.binding(data: listDataToShow[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailTransactionViewController(data: listDataToShow[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Xoá") {[weak self] (action, sourceView, completionHandler) in
            guard let self = self else {
                completionHandler(false)
                return
            }
            let transfer = self.listDataToShow[indexPath.row]
            self.listHistory?.removeAll(where: {$0.id == transfer.id})
            self.listDataToShow.remove(at: indexPath.row)
            AppData.listTransaction = self.listHistory
            tableView.reloadData()
            completionHandler(true)
        }
        
        let rename = UIContextualAction(style: .normal, title: "Sửa") { (action, sourceView, completionHandler) in
            print("index path of edit: \(indexPath)")
            let transfer = self.listDataToShow[indexPath.row]
//            self.listHistory?.removeAll(where: {$0.id == transfer.id})
//            self.listDataToShow.remove(at: indexPath.row)
//            AppData.listTransaction = self.listHistory
            if transfer.isReceive == true {
                let vc = PastInTransactionViewController()
                vc.transfer = transfer
                vc.editComplete = {
                    self.listHistory = AppData.listTransaction?.sorted(by: {($0.date?.timeIntervalSince1970 ?? 0) > ($1.date?.timeIntervalSince1970 ?? 0)})
                    self.listDataToShow.removeAll()
                    if let listHistory = self.listHistory {
                        listHistory.forEach {[weak self] element in
                            guard let self = self else {return}
                            if (element.date ?? .init()) >= self.start && (element.date ?? .init()) <= self.end {
                                switch self.type {
                                case .moneyOut:
                                    if element.isReceive == false {
                                        self.listDataToShow.append(element)
                                    }
                                case .moneyIn:
                                    if element.isReceive == true {
                                        self.listDataToShow.append(element)
                                    }
                                case .total:
                                    self.listDataToShow.append(element)
                                }
                            }
                        }
                    }
                    
                    self.listDataToShow = self.listDataToShow.sorted(by: {($0.date?.timeIntervalSince1970 ?? 0) > ($1.date?.timeIntervalSince1970 ?? 0)})
                    tableView.reloadData()
                }
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = PastOutTransactionViewController()
                vc.transfer = transfer
                vc.editComplete = {
                    self.listHistory = AppData.listTransaction?.sorted(by: {($0.date?.timeIntervalSince1970 ?? 0) > ($1.date?.timeIntervalSince1970 ?? 0)})
                    self.listDataToShow.removeAll()
                    if let listHistory = self.listHistory {
                        listHistory.forEach {[weak self] element in
                            guard let self = self else {return}
                            if (element.date ?? .init()) >= self.start && (element.date ?? .init()) <= self.end {
                                switch self.type {
                                case .moneyOut:
                                    if element.isReceive == false {
                                        self.listDataToShow.append(element)
                                    }
                                case .moneyIn:
                                    if element.isReceive == true {
                                        self.listDataToShow.append(element)
                                    }
                                case .total:
                                    self.listDataToShow.append(element)
                                }
                            }
                        }
                    }
                    
                    self.listDataToShow = self.listDataToShow.sorted(by: {($0.date?.timeIntervalSince1970 ?? 0) > ($1.date?.timeIntervalSince1970 ?? 0)})
                    tableView.reloadData()
                    tableView.reloadData()
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [rename, delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
}

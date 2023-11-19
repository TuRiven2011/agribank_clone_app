

import UIKit

class TransactionHistoryViewController: BaseViewController {
    
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var numberAccount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var startDateView: UIView!
    
    var listHistory = AppData.listTransaction?.sorted(by: {($0.date?.timeIntervalSince1970 ?? 0) > ($1.date?.timeIntervalSince1970 ?? 0)})
    var listDataToShow: [TransferModel] = []
    var type = TransactionEnum.total
    let datePicker = UIDatePicker()
    var start: Date = .init()
    var end: Date = .init()
    var isSearch = false
    
    let enumM: TransactionEnum? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        APP_DELEGATE?.appNavigator?.navigation.isNavigationBarHidden = false
        APP_DELEGATE?.appNavigator?.navigation.navigationBar.isHidden = false
        APP_DELEGATE?.appNavigator?.navigation.setNavigationBarHidden(false, animated: true)
        setupNavigationBarSwitch(title: "LỊCH SỬ GIAO DỊCH")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
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
        numberAccount.text = AppData.account?.numberAccount ?? ""
        buttonCollection.forEach { button in
            button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handle(_:))))
        }
        startDateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPickerStartDate)))
        endDateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPickerEndDate)))
        searchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchTransaction)))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        APP_DELEGATE?.appNavigator?.navigation.isNavigationBarHidden = true
        APP_DELEGATE?.appNavigator?.navigation.navigationBar.isHidden = true
        APP_DELEGATE?.appNavigator?.navigation.setNavigationBarHidden(true, animated: true)
        APP_DELEGATE?.appNavigator?.tabbar.selectedIndex = 0
//        setupNavigationBarSwitch(title: "LỊCH SỬ GIAO DỊCH")
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
                self.listDataToShow = self.listDataToShow.sorted(by: {($0.date?.timeIntervalSince1970 ?? 0) > ($1.date?.timeIntervalSince1970 ?? 0)})
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
        isSearch = true
        listHistory = AppData.listTransaction?.sorted(by: {($0.date?.timeIntervalSince1970 ?? 0) > ($1.date?.timeIntervalSince1970 ?? 0)})
        listDataToShow.removeAll()
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
        
        listDataToShow = listDataToShow.sorted(by: {($0.date?.timeIntervalSince1970 ?? 0) > ($1.date?.timeIntervalSince1970 ?? 0)})
        tableView.reloadData()
    }
}

extension TransactionHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listDataToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionListTableViewCell") as? TransactionListTableViewCell else {return UITableViewCell()}
        
            cell.binding(data: listDataToShow[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailTransactionViewController(data: listDataToShow[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}



import UIKit

class TransactionHistoryViewController: BaseViewController {
    
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var openBranchLabel: UILabel!
    @IBOutlet weak var numberAccount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var startDateView: UIView!
    
    var listHistory = AppData.listTransaction
    var listDataToShow: [TransferModel] = []
    var type = TransactionEnum.total
    let datePicker = UIDatePicker()
    var start: Date = .init()
    var end: Date = .init()
    var isSearch = false
    
    let enumM: TransactionEnum? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarSwitch(title: "LỊCH SỬ GIAO DỊCH")
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
        openBranchLabel.text = AppData.account?.openBranch ?? ""
        buttonCollection.forEach { button in
            button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handle(_:))))
        }
        startDateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPickerStartDate)))
        endDateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPickerEndDate)))
        searchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchTransaction)))
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
        listHistory = AppData.listTransaction
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
    
    
}

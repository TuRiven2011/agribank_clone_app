

import UIKit

class TransferByOtherBankViewController: BaseViewController {

    @IBOutlet weak var scrollView: TPKeyboardAvoidingScrollView!
    @IBOutlet weak var contentTransferTextField: UITextField!
    @IBOutlet weak var bankCollectionView: UICollectionView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var myNumberAccountLabel: UILabel!
    @IBOutlet weak var myBalanceLabel: UILabel!
    @IBOutlet weak var moneyTransferTextField: UITextField!
    @IBOutlet weak var transferAccountNumberTextField: UITextField!
    
    let banks: [AppBankEnum] = AppBankEnum.allCases
    
    @IBAction func cancelAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        guard let account = AppData.account else {return}
        var newData = account
        if let money = Int(moneyTransferTextField.text ?? "0") {
            newData.balance = (account.balance ?? 0) - money
        }
        
        AppData.account = newData
        
        let billModel = TransferModel(userName: AppData.account?.userName,
                                      numberAccount: AppData.account?.numberAccount,
                                      balance: AppData.account?.balance,
                                      openBranch: AppData.account?.openBranch,
                                      content: contentTransferTextField.text,
                                      money: Int(moneyTransferTextField.text ?? "0"),
                                      numberTransferAccount: transferAccountNumberTextField.text,
                                      bankTransfer: "VietinBank",
                                      date: .init(),
                                      isReceive: false
        )
        
        AppData.listTransaction?.append(billModel)
        
        print(AppData.listTransaction)
        
        let vc = TransactionDetailViewController(data: billModel)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configCollectionView()
        setup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(title: "CK nhanh qua số tk".uppercased())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nextButton.applyGradient(colours: [.init(rgb: 0xffDF8B31), .init(rgb: 0xffC46826)],
                                 start: .init(x: 0, y: 0),
                                 end: .init(x: 1, y: 0))
    }
    
    private func configCollectionView() {
        bankCollectionView.register(.init(nibName: "BankCollectionViewCell",
                                          bundle: nil), forCellWithReuseIdentifier: "BankCollectionViewCell")
        bankCollectionView.delegate = self
        bankCollectionView.dataSource = self
        bankCollectionView.collectionViewLayout = generateLayout()
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 40, height: 40)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 24
        return layout
    }
    
    private func setup() {
//        scrollView.keyboardDismissMode = .interactive
        cancelButton.layer.cornerRadius = cancelButton.frame.height/2
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.borderColor = UIColor(rgb: 0xffC46826).cgColor
        cancelButton.layer.borderWidth = 2
        nextButton.layer.cornerRadius = cancelButton.frame.height/2
        nextButton.layer.masksToBounds = true
        guard let account = AppData.account else {return}
        myBalanceLabel.text = account.balance?.addComma()
        myNumberAccountLabel.text = account.numberAccount ?? ""
        myBalanceLabel.text = account.balance?.addComma()
        contentTransferTextField.text = "\(account.userName?.uppercased() ?? "") chuyen khoan"
    }

}

extension TransferByOtherBankViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BankCollectionViewCell", for: indexPath) as? BankCollectionViewCell else {return .init()}
        cell.binding(data: banks[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

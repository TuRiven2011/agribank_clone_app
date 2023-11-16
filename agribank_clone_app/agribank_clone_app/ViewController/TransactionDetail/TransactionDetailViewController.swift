

import UIKit

class TransactionDetailViewController: BaseViewController {

    var data: TransferModel
    
    @IBOutlet weak var goHomeImage: UIImageView!
    @IBOutlet weak var numberAccount2LAbel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var bank2Label: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var name2Label: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    required init(data: TransferModel) {
        self.data = data
        
        super.init(nibName: "TransactionDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func handleBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentInsetAdjustmentBehavior = .never
        setup()
        setupControlEvent()

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setup() {
        numberAccount2LAbel.text = data.numberAccount2 ?? ""
        moneyLabel.text = "\(data.money?.addComma() ?? "") VND"
        bank2Label.text = data.bank2 ?? ""
        contentLabel.text = data.content ?? ""
        name2Label.text = data.name2 ?? ""
        dateLabel.text = Date.init().formatToString()
        codeLabel.text = data.code
    }
    
    private func setupControlEvent() {
        goHomeImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleGoGome)))
    }

}

extension TransactionDetailViewController {
    @objc func handleGoGome() {
        let vc: UIViewController? = navigationController?.viewControllers.first(where: {$0 is HomeViewController})
        if let vc = vc {
            navigationController?.popToViewController(vc, animated: true)
        }
    }
}

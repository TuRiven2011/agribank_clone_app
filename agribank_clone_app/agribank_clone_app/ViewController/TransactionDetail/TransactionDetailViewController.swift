

import UIKit

class TransactionDetailViewController: BaseViewController {

    var data: TransferModel
    
    @IBOutlet weak var goHomeImage: UIImageView!
    @IBOutlet weak var myNumberAccountLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    required init(data: TransferModel) {
        self.data = data
        
        super.init(nibName: "TransactionDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentInsetAdjustmentBehavior = .never
        setup()
        setupControlEvent()

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setup() {
        myNumberAccountLabel.text = data.numberAccount ?? ""
        moneyLabel.text = data.money?.addComma()
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

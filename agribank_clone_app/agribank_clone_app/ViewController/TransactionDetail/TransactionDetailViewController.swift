//
//  TransactionDetailViewController.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 12/11/2023.
//

import UIKit

class TransactionDetailViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentInsetAdjustmentBehavior = .never
        

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }

}

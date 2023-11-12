//
//  TransferByOtherBankViewController.swift
//  agribank_clone_app
//
//  Created by Phạm Bá Tú on 12/11/2023.
//

import UIKit

class TransferByOtherBankViewController: BaseViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func cancelAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    private func setup() {
        cancelButton.layer.cornerRadius = cancelButton.frame.height/2
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.borderColor = UIColor(rgb: 0xffC46826).cgColor
        cancelButton.layer.borderWidth = 2
        nextButton.layer.cornerRadius = cancelButton.frame.height/2
        nextButton.layer.masksToBounds = true
    }

}

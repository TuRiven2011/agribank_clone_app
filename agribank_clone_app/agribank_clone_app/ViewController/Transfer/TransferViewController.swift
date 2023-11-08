//
//  TransferViewController.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 16/10/2023.
//

import UIKit

class TransferViewController: BaseViewController {

    @IBOutlet weak var transferCollectionView: UICollectionView!
    
    @IBOutlet weak var transferTableView: UITableView!
    
    let data: [TransferEntity] = [.init(title: "Chuyển khoản nội bộ qua TK/ĐT", image: "ic48PxCKnoiboquaStk_Normal"), .init(title: "CK LNH qua số tài khoản", image: "ic48PxCKlienNHquaStk_Normal"), .init(title: "CK LNH qua số thẻ", image: "ic48PxCKlienNHquasothe_Normal"), .init(title: "Chuyển khoản 24/7 mã QR", image: "ic48PxQrpay_Normal"), .init(title: "Chuyển khoản LNH thường", image: "ic48PxChuyenkhoan_Normal")]
    
    let tableData: [beneficiaryListEntity] = [.init(name: "Van Hao", accountnumber: "Vietinbank-1029302940423", bankImage: "Logo_Viettinbank_Normal"), .init(name: "Van Hao", accountnumber: "Vietinbank-1029302940423", bankImage: "Logo_Viettinbank_Normal"), .init(name: "Van Hao", accountnumber: "Vietinbank-1029302940423", bankImage: "Logo_Viettinbank_Normal"), .init(name: "Van Hao", accountnumber: "Vietinbank-1029302940423", bankImage: "Logo_Viettinbank_Normal"), .init(name: "Van Hao", accountnumber: "Vietinbank-1029302940423", bankImage: "Logo_Viettinbank_Normal"), .init(name: "Van Hao", accountnumber: "Vietinbank-1029302940423", bankImage: "Logo_Viettinbank_Normal"), .init(name: "Van Hao", accountnumber: "Vietinbank-1029302940423", bankImage: "Logo_Viettinbank_Normal"), .init(name: "Van Hao", accountnumber: "Vietinbank-1029302940423", bankImage: "Logo_Viettinbank_Normal")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isHidden = false
        
        setupNavigationBar(title: "Chuyển khoản")
    }

    func config() {
        transferCollectionView.register(.init(nibName: "TransferCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TransferCollectionViewCell")
        transferTableView.register(.init(nibName: "TransferTableViewCell", bundle: nil), forCellReuseIdentifier: "TransferTableViewCell")
        transferCollectionView.delegate = self
        transferCollectionView.dataSource = self
        transferTableView.delegate = self
        transferTableView.dataSource = self
    }


}

extension TransferViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransferCollectionViewCell", for: indexPath) as? TransferCollectionViewCell else {return UICollectionViewCell()}
        
        cell.binding(data[indexPath.row].title, data[indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 16)/3
        return CGSize(width: size, height: size)
    }
    
}

extension TransferViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransferTableViewCell") as? TransferTableViewCell else {return UITableViewCell()}
        
        cell.binding(tableData[indexPath.row].name, tableData[indexPath.row].accountnumber, tableData[indexPath.row].bankImage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    
}
